CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'




rm -rf student-submission
git clone $1 student-submission
echo 'Finished cloning'


cd student-submission




if [[ -f "ListExamples.java" ]]
then
    echo "ListExamples found"
else
   echo  "need ListExamples"
   exit 1
fi


for FILE in *;
do
    if [[ -e $FILE ]]
    then
        echo $FILE "found"
    else
        echo "need" $FILE
        exit 1
    fi
done


cp ListExamples.java ..
cd ..


javac -cp $CPATH *.java 2> javac-errs.txt


if [[ $? -ne  0 ]]
then
    cat javac-errs.txt
    exit 1
fi
java -cp $CPATH org.junit.runner.JUnitCore TestListExamples 2>java-error.txt > results.txt

cat results.txt

sed '2,2!d' results.txt > score.txt

FAILURES="$(grep -c "E" score.txt)"
SUCCESSES=`grep -c "." score.txt`

total=`expr $FAILURES + $SUCCESSES`

echo "Score: "
echo $SUCCESSES / $total

