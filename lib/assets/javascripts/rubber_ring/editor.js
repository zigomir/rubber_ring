//= require jquery
//= require jquery_ujs

var App = App || {};

(function() {
  "use strict";
  var $contentEditable = $('[contenteditable]');

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

    $contentEditable.change(function(e) {
      var key        = $(e.currentTarget).data("cms"),
//          textValue  = e.currentTarget.textContent,
          htmlValue  = e.currentTarget.innerHTML,
          postObject = {page_controller: App.controller, page_action: App.action, key: key, value: htmlValue};

      console.group("Sending CMS content to server...");
      console.log("'%s' => '%s'", postObject.key, postObject.value);
      console.groupEnd();

      $.post(App.save_path, postObject, function(data) {
        console.log(data);
        // reload if value was empty - to clear contenteditable br and div tags
        if (postObject.value === '') {
          window.location.reload(true);
        }
      });
    });

    // disable enter in single line editor
    $contentEditable.not('.multi-line').keydown(function(e) {
      if (e.keyCode === 13) {
        e.preventDefault();
      }
    });

  });
})();
