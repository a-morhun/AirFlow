function setLinkAsActive(id) {
    $(".nav-link").removeClass('active');
    $("#" + id).addClass('active');
}

function sendEmailRequest(callback) {
    var acId = $("#acModal").find('.modal-title').data('id');
    var acName = $("#acModal").find('.modal-title').text();
    var desiredTemperature = $("#desiredTemperature").val();
    $.ajax({
        url: '/Umbraco/api/AirConditionUnits/Request',
        dataType: "json",
        type: "POST",
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify({ airConditionUnitId: acId, airConditionUnitName: acName, temperature: desiredTemperature }),
        async: true,
        processData: false,
        cache: false,
        success: function (response) {
            var lastTemperature = "";
            if (response.history && response.history.length) {
                lastTemperature = response.history[0].Temperature;
            }
            modal = $('#acModal');
            modal.find('#currentTemperature').val(lastTemperature);
            document.getElementById("acHistory").innerHTML = getHistoryHtml(response.history);
        },
        error: function (xhr) {
            alert('error');
        }
    })
}

function getRequestHistory(id, success) {
    $.ajax({
        url: '/Umbraco/api/AirConditionUnits/History/'+id,
        dataType: "json",
        type: "GET",
        contentType: 'application/json; charset=utf-8',
        async: true,
        processData: false,
        cache: false,
        success: function (response) {
            success(response);
        },
        error: function (xhr) {
            alert('error');
        }
    });
}

function openAcModal(dataset) {
    var title = dataset['title'],
        id = dataset['id'],
        min = dataset['min'],
        max = dataset['max'],
        modal = $('#acModal');

    getRequestHistory(id, (response) => {
        var lastTemperature = "";
        if (response.history && response.history.length) {
            lastTemperature = response.history[0].Temperature;
        }
        modal.modal('show');
        modal.find('.modal-title').text(title);
        modal.find('.modal-title').data('id', id);
        modal.find('#currentTemperature').val(lastTemperature);
        modal.find('#desiredTemperature').attr({ min: min, max: max }).val(lastTemperature);
        document.getElementById("acHistory").innerHTML = getHistoryHtml(response.history);
    });
}

function getHistoryHtml(history) {
    var txt = "";
    if (history.length) {
        txt += "<table class='table table-bordered'>";
        txt += "<thead><tr><th scope='col'>Name</th><th scope='col'>Temperatute</th><th scope='col'>Date</th></tr></thead>";
        for (x in history) {
            txt += "<tr><td>" +
                history[x].RequesterEmail +
                "</td><td>" +
                history[x].Temperature +
                "</td><td>" +
                history[x].RequestDateTime +
                "</td></tr>";
        }
        txt += "</table>";
    }
    return txt;
}