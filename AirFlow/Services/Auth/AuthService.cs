﻿using System;
using AirFlow.Data;
using AirFlow.Data.Models;
using AirFlow.Models.Auth;
using AirFlow.Models.Common;
using AirFlow.ServiceContainers;
using Autofac;

namespace AirFlow.Services.Auth
{
    public class AuthService : IAuthService
    {
        private readonly IMembership _membership;
        private readonly IUserRepository _userRepository;
        private readonly IAuthRepository _authRepository;

        public AuthService(
            IMembership membership,
            IAuthRepository authRepository,
            IUserRepository userRepository)
        {
            _membership = membership;
            _authRepository = authRepository;
            _userRepository = userRepository;
        }

        public LoginResult Login(UserToLogin user)
        {
            AdditionalLoginInfo additionalInfo = _userRepository.GetAdditionalLoginInfo(user.Email);

            if (additionalInfo == null)
            {
                return new LoginResult(ErrorCodeType.MemberNotFound);
            }

            if (!_membership.ValidateUser(additionalInfo.Username, user.Password))
            {
                return new LoginResult(ErrorCodeType.MemberIsNotApprovedOrInvalidCredentials);
            }

            if (!_authRepository.IsEmailConfirmed(user.Email))
            {
                return new LoginResult(ErrorCodeType.MemberHasNotConfirmedEmail);
            }

            var type = (LoginType)additionalInfo.LoginType;

            if (type == LoginType.TwoFactorEmail)
            {
                var processor = AirFlowServiceContainer.Container.Resolve<ITwoFactorLoginProcessor>(new NamedParameter("userEmail", user.Email));
                processor.Process(additionalInfo.UserId);
            }

            return new LoginResult(additionalInfo.Username, type);
        }


        public Result ConfirmEmail(string token)
        {
            ConfirmationToken tokedDetails = _authRepository.GetConfirmationTokenDetails(token);

            if (tokedDetails == null)
            {
                return new Result(ErrorCodeType.ConfirmationTokenInfoNotFound);
            }

            if (tokedDetails.AlreadyConfirmed)
            {
                return new Result(ErrorCodeType.MemberHasAlreadyConfirmedEmail);
            }

            if (tokedDetails.IsExpired)
            {
                return new Result(ErrorCodeType.ConfirmationTokenIsExpired);
            }

            try
            {
                _authRepository.ConfirmEmail(tokedDetails.ForUserId);
            }
            catch (Exception e)
            {
                return new Result(ErrorCodeType.UnknownError, e.Message);
            }

            return Result.Success;
        }

        public LoginResult ConfirmLogin(string token)
        {
            Token tokenDetails = _authRepository.GetLoginTokenDetails(token);

            if (tokenDetails == null)
            {
                return new LoginResult(ErrorCodeType.LoginTokenInfoNotFound);
            }

            if (tokenDetails.IsExpired)
            {
                return new LoginResult(ErrorCodeType.LoginTokenIsExpired);
            }

            string username;
            try
            {
                username = _authRepository.ConfirmLogin(tokenDetails.ForUserId);
            }
            catch (Exception e)
            {
                return new LoginResult(ErrorCodeType.UnknownError, e.Message);
            }

            return new LoginResult(username);
        }
    }
}