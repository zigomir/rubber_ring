var App = App || {};

(function() {
  "use strict";


  function resetEdit(edit) {
    if (edit !== null && edit.element !== null && edit.input !== null) {
      // switch to new value
      edit.element.text(edit.input.val());

      edit.element.show();
      edit.input.remove();
    }

    return {
      element: null,
      input: null
    };
  }

  App.resetEdit = resetEdit;
})();

App.edit = App.resetEdit(null);

$(function() {
  "use strict";

  // on doubleclick of all data-cms that ends with text
  $("body > *[data-cms$=text]").on("dblclick", function (e) {
    var $clickedElement = $(e.currentTarget),
        value = $clickedElement.text();

    $clickedElement.focus();

    if (value.length > 0) {
      console.log(value);
      App.edit.element = $(e.currentTarget);

      // here change this to input
      App.edit.input = $('<input type="text" class="edit" value="' + value + '" />').insertAfter($clickedElement);
      App.edit.input.focus();
      $clickedElement.hide();
    }
  });

  $("body").on("blur", "input.edit", function(e) {
    App.resetEdit(App.edit);
  });

  $("body").on("change", "input.edit", function(e) {
    var $editedValue = $(e.currentTarget),
        key          = App.edit.element.data("cms").split(":")[0],
        value        = $editedValue.val();

    console.log(key + " => " + value);

    // TODO client doesn't have to know routes before
    $.post('admin/cms/save', {prefix: App.prefix, value: value}, function(data) {
      console.log(data);
      App.resetEdit(App.edit);
    });
  });
});
