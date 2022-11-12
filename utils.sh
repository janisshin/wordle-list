#/bin/bash

chooseWordbank(){
  echo "which wordbank do you want to use?"
  echo "1) All possible 5-letter words\n2) Only the words from the official answer list\nChoose either 1 or 2 and press enter."
  read mode

  while [ "$mode" != "1" ] || [ $x != "2" ]
  do
      echo "Choose either 1 or 2 and press enter."
      read mode
  done

    if [[ "$mode" == "1" ]]
    then
        curl -s https://raw.githubusercontent.com/janisshin/wordle-list-generator/main/words | grep ...
  elif [[ "$mode" == "2" ]]
  then
      curl -s https://raw.githubusercontent.com/janisshin/wordle-list-generator/main/words | grep ...
  done
}

takeInLetters(){
    echo "Enter all guessed letters in order: "
    read guesses
    
    while [[ ${#guesses} != 5 ]]
    do
        echo "The number of letters entered must be 5. Please try again."
        read guesses
    done
   

    echo "Enter in the color codes of your guessed letters in order:\n b:black\ny:yellow\ng:green"
    echo "For example, black, yellow, black, green, black would be bybgb"
    read color_codes
    
    # make color_code lowercase
    color_codes=`echo "$color_codes" | tr '[:upper:]' '[:lower:]'`

    while [[ ${#color_codes} != 5 ]] || [[ $color_codes != +("b" "y" "g") ]]
    do
        echo "The number of letters entered must be 5 and only "b", "y", and "g" are accepted as color codes. Please try again."
        read $color_codes
    done

    # somehow store these values and positions   
}

performRegex(){
    #construct the string
}

provideWords(){
    # calculate which words are possible 

    if $possible == 0,
    do
        echo "I'm sorry to say I cannot think of any possible words."
    else
        echo "here are the possible words:"
    done    
}

checkToContinue(){
    while $continue != 'y' or 'n':
    do 
        echo "Enter a new round of letters? y/n"
        read continue
    done
}

program(){
    continue='y'
    while $continue == 'y'
    do 
        takeInLetters()
        provideWords()
        continue='z'
        checkToContinue()
    done
}

