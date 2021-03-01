import Sortable from "sortablejs";

document.addEventListener('turbolinks:load', function (){
    var el = document.getElementById('blocks-list');
    var sortable = Sortable.create(el, {
        animation: 150,
        ghostClass: 'light-bg'
    });
});
//
// import 'jquery-ui/ui/widgets';
//
// jQuery(document).ready(function($){ //когда страница прогрузилась
//     // ваш код
//     document.addEventListener('turbolinks:load', function (){
//         $("#blocks-list").sortable(
//             {
//             update: function(e, ui) {
//                 Rails.ajax({
//                     url: $(this).data("url"),
//                     type: "PATCH",
//                     data: $(this).sortable('serialize'),
//                 });
//             }
//         }
//         );
//
//
//     });
// });


