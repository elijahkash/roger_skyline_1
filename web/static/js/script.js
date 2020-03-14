var btn = document.getElementById("btn_one"); 
var text = document.getElementById("input_text");
var i = 0;

btn.addEventListener('click', function(e) {
  e.preventDefault();
  i++;
  var target = document.getElementById("str_" + i);

  console.log(text.value); 
  if (text.value == 'clear') {
    window.location.reload();
    
  }
  target.innerHTML = text.value;
  document.getElementById('input_text').value = '';

});

