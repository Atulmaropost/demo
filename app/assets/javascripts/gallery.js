 $( document ).ready(function() {

    $(function () {
        $('.mm_tooltip').tooltip({
            selector: "[data-toggle=tooltip]",
            container: "body"
        })
    });
 
    $('.thumbnail').hover(
        function(){
            $(this).find('.caption').slideDown(300); //.fadeIn(250)
        },
        function(){
            $(this).find('.caption').slideUp(200); //.fadeOut(205)
        }
    ); 
    
    $('#btndel').on('click', function(){
        alert('Are you sure you want to delete');
        
    });

});