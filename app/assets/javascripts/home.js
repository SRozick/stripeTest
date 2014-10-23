$(function()
  {
    $(document).foundation(
      {
        offcanvas :
        { // see http://foundation.zurb.com/docs/components/offcanvas.html
          open_method: 'move',      //offcanvas moves content on open
          close_on_click : true     //click on offcanvas closes menu
        }
      });

// Control fixed behaviour of off-canvas menu
//  Coordinates with CSS class for left-off-canvas-menu
//  TODO: Watch Foundation for a fix to this issue, off-canvas-menu fixed pos
    var menu = $('.left-off-canvas-menu');

    $(document).on('resize', function() {
      menu.height($(this).height());
    });

    $(document).trigger('resize');
  });
