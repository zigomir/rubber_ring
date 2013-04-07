//= require jquery
//= require jquery_ujs

var App = App || {};
App.edit = {};

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

  function getKey() {
    if (App.edit.element === undefined) {
      console.warn("Can't get key because cms element is not even set!");
    }

    return App.edit.element.data("cms");
  }

  App.edit.getKey = getKey;
  App.edit.reset  = resetEdit;
})();

$(function() {
  "use strict";

  // on double click of all data-cms-type="text"
  $("body *[data-cms-type=text]").on("dblclick", function (e) {
    var $clickedElement = $(e.currentTarget),
        value = $clickedElement.text();

    $clickedElement.focus();

    if (value.length > 0) {
      App.edit.element = $(e.currentTarget);

      console.group("Editing CMS content");
      console.log("Content key '%s'", App.edit.getKey());
      console.log("Content value '%s'", value);
      console.groupEnd();

      // here change this to input
      App.edit.input = $('<input type="text" class="edit" value="' + value + '" />').insertAfter($clickedElement);
      App.edit.input.focus();
      $clickedElement.hide();
    }
  });

  $("body").on("blur", "input.edit", function(e) {
    App.edit.reset(App.edit);
  });

  $("body").on("change", "input.edit", function(e) {
    var $editedValue = $(e.currentTarget),
        value        = $editedValue.val(),
        postObject   = {page_controller: App.controller, page_action: App.action, key: App.edit.getKey(), value: value};

    // TODO client doesn't have to know routes before
    $.post('rubber_ring/cms/save', postObject, function(data) {
      console.log(data);
      App.edit.reset(App.edit);
    });
  });
});
