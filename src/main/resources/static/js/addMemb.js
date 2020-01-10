/**
    * @author Umberto Russomando
    * this javascript remove a group member from the view 
    * 
*/

$(document).ready(function(){
    $(".addMemb").click(function () {
        var wrapper = $(".groupMemb").filter($(this).parents());
        var username = $("#nametoget").val();
        var idGroup = $(this).attr("id");
        alert(username);
        alert(idGroup);
        var url = "/api/group/addMember/"+idGroup+"/"+username;

        alert("are you sure you want to add this member in this group?");
        $.ajax({
            dataType: "text",
            url:url,
            headers:{
             'Accept' : 'application/json',
             'Content-Type' : 'application/json'
            },
            type:'POST',
            success:function(data){
                alert("success");
                //wrapper.remove();
            },
           error:function(request,textStatus,errorThrown){
                alert("failed:");
            }
        });
        
     });
});