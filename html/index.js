$(function () {
    function display(bool) {
        if (bool) {
            $("#container").show();
        } else {
            $("#container").hide();
        }
    }

    display(false)

    window.addEventListener('message', function(event) {
        var item = event.data;
        if (item.type === "ui") {
            if (item.status == true) {
                display(true)
            } else {
                display(false)
            }
        }
    })
    // if the person uses the escape key, it will exit the resource
    document.onkeyup = function (data) {
        if (data.which == 27) {
            $.post('http://souki_graphity/exit', JSON.stringify({}));
            return
        }
    };
    $("#close").click(function () {
        $.post('http://souki_graphity/exit', JSON.stringify({}));
        return
    })
    //when the user clicks on the submit button, it will run
    $("#submit").click(function () {
        let inputValue = $("#input").val()
        let inputValue2 = $("#input2").val()
        let inputValue3 = $("#input3").val()
        let inputValue4 = $("#input4").val()
        if (inputValue.length >= 100) {
            $.post("http://souki_graphity/error", JSON.stringify({
                error: "Input was greater than 100"
            }))
            return
        } else if (!inputValue) {
            $.post("http://souki_graphity/error", JSON.stringify({
                error: "There was no value in the input field"
            }))
            return
        }
        // if there are no errors from above, we can send the data back to the original callback and hanndle it from there
        $.post('http://souki_graphity/main', JSON.stringify({
            text: inputValue,
            police: inputValue2, 
            taille: inputValue3,
            color: inputValue4,
        }));
        return;
    })
})
function updateTextInput(val) {
    document.getElementById('input3').value=val; 
  }

