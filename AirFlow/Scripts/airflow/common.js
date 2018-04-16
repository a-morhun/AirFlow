function setLinkAsActive(id) {
    $(".nav-link").removeClass('active');
    $("#" + id).addClass('active');
}