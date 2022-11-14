#/bin/bash

# yes, I know that NYT highlights incorrect letters gray, but since both "gray" and "green" start with "gr", I will just pretend gray = black


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
        wordFile="https://github.com/janisshin/wordle-list-generator/blob/main/all_possible.txt.txt"
  elif [[ "$mode" == "2" ]]
  then
      wordFile="https://github.com/janisshin/wordle-list-generator/blob/main/only_solutions.txt"
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

positionalSearch(varName, letter, position, invert){
    # varName = string (this is because bash does not allow returns in functions)
    # letter = char
    # position = array
    # invert = bool

    blank="....."
    if [[ $invert ]]; then
        for letter, position in gList
        do
            declare ${varName}=`echo $positions | sed s/./$letter/$position`
        done
    else
        for letter, position in gList
        do
            declare ${varName}=`echo $positions | sed s/./$letter/$position`
        done
    fi
    
}

performRegex(bList, yList, gList){
    #construct the string
    # bList is a list of letters that are highlighted black
    # yList is an array where each element consists one letter and a variable amount of numbers
    # gList is an array where each element consists of one letter and one number

    elimBlack=`curl -s "$wordFile" | grep -v $bList`

    # green
    positionalSearch(gString, (${gList[0]}), (${gList[1]}), false)

    # yellow
    positionalSearch(yString, (${gList[0]}), (${gList[1]}), false)
    ySearch=""
    yExclude=""
    for yArray in yList
    do
        # get first element from array
        yLetter=(${yArray[0]})
        ySearch+="/$yLetter/"
        yPositions=(${yArray[@]:1})

        for place in yPositions
        do
            yString+=`echo $positions | sed s/./$yLetter/$place`
        done
        
    done
    yExclude+=" | grep -v $yString"
    
    # replace all // with / && /
    ySearch=echo "'${yString//\/\//\/ && \/}'"
    # surround with single quotes
    # ySearch="'$ySearch'" # DELETE?

    




    filtered=`echo $elimBlack | awk $gString | awk $yString`
    
    

    filtered=`echo $filtered |       `

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
