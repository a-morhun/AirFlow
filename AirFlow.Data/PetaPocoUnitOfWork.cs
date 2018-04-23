using System;
using PetaPoco;

namespace AirFlow.Data
{
    internal class PetaPocoUnitOfWork : IDisposable
    {
        private readonly Transaction _transaction;
        private readonly Database _database;

        public PetaPocoUnitOfWork()
        {
            _database = new Database(Config.ConnectionStringName);
            _transaction = new Transaction(_database);
        }

        public void Dispose() => _transaction.Dispose();

        public Database Db => _database;

        public void Commit() => _transaction.Complete();
    }
}
