/**
    * @author Umberto Russomando
    * this javascript report a post to an admin
    * 
*/

$(document).ready(function(){
    $(".discard").click(function () {
        var id = $(this).attr("id");
        var url = "/api/post/discard/"+id;
        custom_alert("Message","Are you sure you want to discard this post? By discarding this post you are eliminating it by the list of the reported posts.")
        $.ajax({
            dataType: "text",
            url:url,
            headers:{
             'Accept' : 'application/json',
             'Content-Type' : 'application/json'
            },
            type:'POST',
            success:function(data){
                custom_alert("Message","This post has been successfully discarded");
                window.location.replace("/post/listReportedPosts");
            },
           error:function(request,textStatus,errorThrown){
                custom_alert("Message","failed:");
            }
        });
        
     });
});