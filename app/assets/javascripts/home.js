$(function(){
  $(document).foundation();
});

// expected to stop scrolling when offcanvas element is open
// $(document)
// .on('open.fndtn.offcanvas', '[data-offcanvas]', function() {
//   $('html').css('overflow', 'hidden');
// })
// .on('close.fndtn.offcanvas', '[data-offcanvas]', function() {
//   $('html').css('overflow', 'auto');
// })

// Other functions associated to offcanvas menu behaviour
$(document).foundation({
  offcanvas : {
    // Sets method in which offcanvas opens.
    // [ move | overlap_single | overlap ]
    // move is default, shifts main content away from menu content
    // overlap causes menu content to overlap main content
    // overlap_single causes menu content to overlap single column of main content?
    open_method: 'move',
    // Should the menu close when a menu link is clicked?
    // [ true | false ]
    // default is false
    close_on_click : true
  }
});
