function setLinkAsActive(id) {
    $(".nav-link").removeClass('active');
    $("#" + id).addClass('active');
}

$('#acModal').on('show.bs.modal', function (event) {
    var button = $(event.relatedTarget) // Button that triggered the modal
    var title = button.data('title') // Extract info from data-* attributes
    var id = button.data('id') 
    // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
    // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
    var modal = $(this)
    modal.find('.modal-title').text(title)
    modal.find('.modal-title').data('id', id)
    //modal.find('.modal-body input').val(recipient)
})

function sendEmailRequest() {
    var acId = $("#acModal").find('.modal-title').data('id');
    var desiredT = $("#desiredTemperature").val();
    $.ajax({
        url: '/api/Home/Test',
        dataType: "json",
        type: "POST",
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify({ id: acId, desiredTemperature: desiredT }),
        async: true,
        processData: false,
        cache: false,
        success: function (data) {
            alert(data);
        },
        error: function (xhr) {
            alert('error');
        }
    })
    console.log("lul");
}