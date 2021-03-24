jQuery(function ($){
    $(".deleteAction").click( function (){
        let answer = $(this).parents('div')[0];
        if (confirm("Are you sure?") ) {
            $.ajax({
                url: '/answer/' + $(answer).attr('data-answer_id'),
                type: 'POST',
                data: { _method: 'DELETE'},
                success: function (){
                    $(answer).fadeOut(200);

                }

            });
        }
    });

});