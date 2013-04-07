//= require jquery
//= require jquery_ujs

var App = App || {};

(function() {
  "use strict";

  // jQuery start
  $(function() {
    // register change event for HTML5 content editable
    $('body').on('focus', '[contenteditable]', function() {
      var $this = $(this);
      $this.data('before', $this.html());
      return $this;
    }).on('blur', '[contenteditable]', function() {
      var $this = $(this);
      if ($this.data('before') !== $this.html()) {
        $this.data('before', $this.html());
        $this.trigger('change');
      }
      return $this;
    });

    $('[contenteditable]').change(function(e) {
      var key        = $(e.currentTarget).data("cms"),
          value      = e.currentTarget.textContent.toString(),
          postObject = {page_controller: App.controller, page_action: App.action, key: key, value: value};

      // TODO client doesn't have to know routes before
      $.post('rubber_ring/cms/save', postObject, function(data) {
        console.log(data);
      });
    });

  });
})();
