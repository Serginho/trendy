$(document).ready(function(){

    $.each($('i.social'), function (i, v) {
        $(v).click(function(){
            $.ajax({
                type: 'post',
                url: '/shares',
                data: {post_id: $(v).attr('post-id'), site: $(v).attr('site')}
            }).done(function (site) {
                    window.open(site.url+ site.post_url, '_blank')
                    createFlash('Contenido compartido correctamente.', 'success')
                }).fail(function (obj, xd, m) {
                    if( obj.status == 409){
                        createFlash('Ya has compartido este contenido', 'error')
                    }
                    else if (obj.status == 401){
                        createFlash('Esta acción requiere estár logueado', 'error')
                    }
                    else{
                    createFlash('Error al compartir el contenido', 'error')
                    }
                })
        })
    })

    function createFlash(message, type){
        $(".homepage").prepend("<div id='popup-message' style='position: fixed; right:2em; top:2em; z-index: 100'></div>");
        $("#popup-message").append("<div class='message "+type+"'>"+message+"</div>").fadeOut(5000,function(){
            $("#message-box [class*=message]").remove();
            $("#message-box [class=12u]").removeAttr('style')
        })
    }
})
