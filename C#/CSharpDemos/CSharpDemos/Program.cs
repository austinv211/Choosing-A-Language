using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CSharpDemos
{
    class Program
    {
        static void Main(string[] args)
        {
            #region Running Selection Sort
            //RUNNING SELECTION SORT
            //create a test array
            int[] testList = { 13, 21, 1, 4, 90, 123, 18, 2, 6, 5 };

            int[] largeTestList = GetNumbersList();

            //sort the array
            SelectionSort(largeTestList);

            #endregion


            //call a read line so we can see the output
            Console.WriteLine("Enter any key to continue...");
            Console.ReadLine();
        }

        #region Selection Sort and O - Notation Intro
        //this is our selection sort method, it sorts an array of numbers
        static void SelectionSort(int[] array)
        {
            //print the array
            PrintArray("Original Test List:", array);

            var watch = System.Diagnostics.Stopwatch.StartNew();

            //this is our outer loop, it loops from the beginning of the array to the second to last element in the array
            for (int i = 0; i < array.Length - 1; i++)
            {
                //set the minimum to the value at i
                int min = array[i];

                //set the index to i
                int minIndex = i;

                //this is our inner loop, it runs from the value after i to the end of the array
                for (int j = i + 1; j < array.Length; j++)
                {
                    //if the value at j is less than the minimum value, update the minimum value and index to array[j] and j respectively
                    if (min > array[j])
                    {
                        min = array[j];
                        minIndex = j;
                    }
                }

                //if i is no longer the minimum index, then swap it with the current minimum index
                if (i != minIndex)
                {
                    //we set a temp variable here so we do not lose the value of array[i] when we reassign it
                    int temp = array[i];

                    //assign array[i] to the value at the current minimum Index
                    array[i] = array[minIndex];

                    //assign the minimum index value to the temp value of i
                    array[minIndex] = temp;
                }
            }

            watch.Stop();

            //print the result
            PrintArray("Selection Sorted Test List:", array);

            Console.WriteLine("Running Time of Method: {0}",watch.Elapsed);
        }

        #endregion

        static int[] GetNumbersList()
        {
            int[] array = new int[10000];
            string resourceString = Resource1.largeListOfNumbers;
            StringReader stringReader = new StringReader(resourceString);

            for (int i = 0; i < 10000; i++)
            {
                array[i] = int.Parse(stringReader.ReadLine());
            }

            return array;
        }

        #region Print Array Method
        static void PrintArray(string header, int[] array)
        {
            Console.WriteLine(header);

            for (int i = 0; i < array.Length; i++)
            {
                Console.Write(array[i] + " ");
            }

            Console.WriteLine("\n");
        }
        #endregion
    }
}
