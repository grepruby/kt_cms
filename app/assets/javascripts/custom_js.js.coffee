$(document).ready ->
  $(document).on "click", ".remove", ->
    $(this).closest(".element-row").remove()

  $(document).on "click", ".options", ->
    if $(this).val() is "radio" or $(this).val() is "check_boxes" or $(this).val() is "select"
      $(this).parent().parent().find("div#options_block").removeClass("hide").addClass "show"
    else
      $(this).parent().parent().find("div#options_block").removeClass("show").addClass "hide"
    if $(this).val() is "text" or $(this).val() is "string"
      $(this).parent().parent().find("div#string_min_block").removeClass("hide").addClass "show"
      $(this).parent().parent().find("div#string_max_block").removeClass("hide").addClass "show"
    else
      $(this).parent().parent().find("div#string_min_block").removeClass("show").addClass "hide"
      $(this).parent().parent().find("div#string_max_block").removeClass("show").addClass "hide"

  $("input.date_picker").datepicker()
  $("input.ui-datetime-picker").datetimepicker()
  $("input.ui-time-picker").timepicker()
