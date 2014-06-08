Rate = function() {
    var state = [];

    return{
       message: function (message, type){
           $(".homepage").prepend("<div id='popup-message' style='position: fixed; right:2em; top:2em; z-index: 100'></div>");
           $("#popup-message").append("<div class='message "+type+"'>"+message+"</div>").fadeOut(5000,function(){
               $("#message-box [class*=message]").remove();
               $("#message-box [class=12u]").removeAttr('style')
           })
       },

       InitStars: function(){
           $.each($("span#rate"), function(i, v){
               $.each($("i", v),function(index, icon){
                   $(icon).mouseover(function (){
                       var n = $(icon).attr('id');
                       while (n > 0) {
                           state.push($('i#'+n, v).attr('class'));
                           $('i#'+n, v).removeClass('fa-star-o');
                           $('i#'+n, v).css('color', '#0090c5')
                           $('i#'+n, v).addClass('fa-star')
                           n=n-1;
                       }
                   });
                   $(icon).mouseout(function (){
                       var n = $(icon).attr('id');
                       var i = 0
                       while (n > 0) {
                           $('i#'+n, v).removeClass('fa-star');
                           $('i#'+n, v).css('color', '#696969');
                           $('i#'+n, v).attr('class',state[i])
                           i=i+1;
                           n=n-1;
                       }
                       state = [];
                   });

                   $(icon).click(function (){
                       $.ajax({
                           type: 'post',
                           url: '/rates',
                           data: {post_id: $(icon).attr('post-id'), score: $(icon).attr('id')}
                       }).done(function (obj, xd, m){
                               if (m.status == 200){
                                   Rate.message("Contenido valorado correctamente.", "success")
                               }
                           }).fail(function(obj, xd, m){
                               if( obj.status == 409){
                                   Rate.message('Ya has valorado este contenido', 'error')
                               }
                               else if (obj.status == 401){
                                   Rate.message('Esta acción requiere estár logueado', 'error')
                               }
                               else{
                                   Rate.message('Error al valorar el contenido', 'error')
                               }
                           })
                   });

               })
           })
       }
    }
}();

$(document).ready(function(){
    Rate.InitStars();
})