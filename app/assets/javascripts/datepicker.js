// datepicker
$(function () {
  $('#datetimepicker').datetimepicker({
      icons: {
          time: "fa fa-clock-o",
          date: "fa fa-calendar",
          up: "fa fa-arrow-up",
          down: "fa fa-arrow-down",
          next: "fa fa-arrow-right",
          previous: "fa fa-arrow-left"
      },
      locale: 'ru',
      inline: true,
      sideBySide: true
  });
});
