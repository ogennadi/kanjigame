$(document).ready(function() {
  var games_count       = 1000;
  var game_index        = Math.floor(Math.random() * games_count);

  $.getJSON('games/'+ game_index +'.json', function(data){
    var word_list         = data["word_list"];
    var character_list    = data["character_list"];
    var time_left         = 59;
    var word_found_array  = init_word_found_array(word_list);
    
    setup_board(word_list);      

    function setup_board(list) {
      // start timer
      var timer = setInterval(function(){
        if (time_left == 0){
          stop_timer();
          end_game();
          return;
        }
        
        time_left--;
        $('#timer').text(time_left);
      }, 1000);
      
      // grid of individual kanji
      for (var i = 0; i < character_list.length; i++){
        $('#'+i).text(character_list[i]);
      }
      
      // list of found words
      for (var i = 0; i < list.length; i++) {
        $('#wordlist').append('<li id="w'+ i +'">'+ mask_word(list[i].word) +'</li>');
      }
      
      // kanji buttons clickable
      $('#board button').click(function(event){
        click_kanji(event.target.id);
      });
    
      // check button clickable
      $('#check').click(function(){
        check();
      });
    }
    
    function click_kanji(id) {
      clicked_kanji = document.getElementById(id);
      
      if (hasClass(clicked_kanji, "clicked")) {
        return;
      }
      
      clicked_kanji.className += " clicked";
      
      selected_paragraph = document.getElementById("selected");
      selected_paragraph.innerHTML = selected_paragraph.innerHTML + clicked_kanji.innerHTML;
    }
    
    function hasClass(element, cls) {
      return (' ' + element.className + ' ').indexOf(' ' + cls + ' ') > -1;
    }
    
    function check() {
      $('#board button').removeClass('clicked');
      check_text = $('p#selected').text();
      $('p#selected').text('');
      
      for (var i = 0; i < word_list.length; i++) {          
        if (word_list[i].word.length == check_text.length && word_list[i].word == check_text) {
          $('#wordlist #w' + i).text(word_list[i].word + ', ' +
                                     word_list[i].reading + ', ' +
                                     word_list[i].meaning);
          word_found_array[i] = true;
          set_status ('found word: ' + word_list[i].word);
          break;
        }
      }
      
      if (end_condition()){
        end_game();
      }
    }
    
    // returns true if the game has been won or lost
    function end_condition() {
      for(var i = 0; i < word_found_array.length; i++){
        if (!word_found_array[i]){
          return false;
        }
      }
      
      return true;
    }
    
    // returns a new array with all elements set to v
    function init_word_found_array(word_list) {
      ret = Array(word_list.length);
      for (var i = 0; i < word_list.length; i++){
        ret[i] = false;
      }
      
      return ret;
    }
    
    function end_game() {
      $('.control').attr('disabled', '');
      stop_timer();
      set_status('Game over');
      display_all_words();
    }
    
    function set_status(text) {
      $('#status').text(text);
    }
    
    function stop_timer() {
      clearInterval(timer);
    }

    
    function mask_word(word){
      var display = Array(word.length);
      
      for(var i = 0; i < display.length; i++ ){
        display[i] = '_';
      }
      
      return display.join(' ');
    }

    function display_all_words() {
      $('#wordlist').html('');

      for (var i = 0; i < word_list.length; i++) {
        $('#wordlist').append('<li id="w'+ i +'" class="'+ (word_found_array[i] ? 'found' :  'notfound') +   '">'+ word_list[i].word + ', ' + word_list[i].reading + ', ' + word_list[i].meaning +'</li>');
      }

    }
  });
});
