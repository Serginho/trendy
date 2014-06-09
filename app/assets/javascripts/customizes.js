$(document).ready(function(){
    $('input[type="range"]').rangeslider({
        polyfill: false,

        // CSS classes
        rangeClass: 'rangeslider',
        fillClass: 'rangeslider__fill',
        handleClass: 'rangeslider__handle',

        // Callback function
        onInit: function() {},

        // Callback function
        onSlide: function(position, value) {
            $('.rangeslider__handle').attr('data-content', value);
        },

        // Callback function
        onSlideEnd: function(position, value) {}
    });
})

