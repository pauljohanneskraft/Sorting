
import sorting_algorithms.*;

import java.text.*;
import java.util.*;

public class UseCase {
    // | = new round, _ = sorting successful, x = sorting unsuccessful, e = Exception/Error thrown
    private static final boolean showRoundResults = false;
    private static final boolean showCreatedArray = false;
    private static final boolean showRound = false;
    // if(round > 100) -> "+" for every 10 rounds
    private static final int rounds = 10;
    private static final int elements = 1000;
    private static Sort[] algos = {
            new BubbleSort(),
            new InsertionSort(),
            new SelectionSort(),
            new HeapSort(),
            new MergeSort(),
            new MergeSortInPlace(),
            new MergeSortThreaded(),
            new AVLBinaryTreeSort(),
            new BinaryTreeSort(),
            new QuickSortThreaded(),
            new QuickSort(),
            new IntroSort(),
            new IntroSortThreaded(),
            new ShellSort()
    };

    public static String addDots(double num) {
        DecimalFormat formatter = (DecimalFormat) NumberFormat.getInstance(Locale.US);
        DecimalFormatSymbols symbols = formatter.getDecimalFormatSymbols();

        symbols.setGroupingSeparator('.');
        symbols.setDecimalSeparator(',');
        formatter.setDecimalFormatSymbols(symbols);

        return formatter.format(num);
    }

    private static long completeTime;

    public static void main(String[] args) {
        completeTime = System.currentTimeMillis();
        if(algos.length == 0) {
            System.out.println("Choose at least one sorting algorithm.");
            return;
        }
        System.out.print("sorting " + addDots(elements) + " elements using Arrays.sort(), ");
        for(int i = 0; i < algos.length - 1; i++) {
            System.out.print(algos[i] + ", ");
        }
        System.out.println(algos[algos.length - 1] + ".");
        Run[][] runs = new Run[rounds][algos.length + 2];
        for(int j = 0; j < rounds; j++) {
            if(showRound) {
                String round = j + 1 + "";
                while(round.length() < (rounds + "").length()) {
                    round = " " + round;
                }
                System.out.println("Round " + round + ": " + elements + " elements");
            } else if(rounds < 100) {
                System.out.print("|");
            } else if(j % 10 == 0) System.out.print("+");
            long time = System.currentTimeMillis();
            Number[] array = new Number[elements];
            for(int i = 0; i < elements; i++) {
                //array[i] = new Number(i/10);
                array[i] = new Number((int)(Math.random()*Integer.MAX_VALUE));
            }
            time = System.currentTimeMillis() - time;
            runs[j][0] = new Run(time, array, "Creation");
            if(showRoundResults) {
                if(showCreatedArray) {
                    System.out.println(runs[j][0]);
                } else {
                    System.out.println("\tCreation: " + time + " ms.");
                }
            }
            Number[] arr = array.clone();
            time = System.currentTimeMillis();
            Arrays.sort(arr);
            time = System.currentTimeMillis() - time;
            runs[j][1] = new Run(time, arr, "Arrays.sort()");
            if(showRoundResults) {
                System.out.println(runs[j][1]);
            } else if(rounds < 100) System.out.print("_");
            for(int k = 0; k < algos.length; k++) {
                runs[j][k + 2] = test(algos[k], array.clone());
            }
            if(showRoundResults) System.out.println();
        }
        if(rounds < 100) {
            System.out.print("|");
        }
        System.out.println("\n");
        AverageRun[] averageRuns = new AverageRun[runs[0].length];
        double[] durations = new double[runs[0].length];
        for(int i = 0; i < runs[0].length; i++) {
            durations[i] = 0;
        }
        for(int i = 0; i < runs.length; i++) {
            for(int j = 0; j < runs[i].length; j++) {
                durations[j] += runs[i][j].time;
            }
        }
        for(int i = 0; i < runs[0].length; i++) {
            averageRuns[i] = new AverageRun((durations[i]/runs.length), runs[0][i].name);
        }
        Arrays.sort(averageRuns);
        for(int i = 0; i < averageRuns.length; i++) {
            System.out.println(averageRuns[i]);
        }
        completeTime = System.currentTimeMillis() - completeTime;
        System.out.println("\ndone. " + addDots(completeTime) + " ms in total, " + addDots((double)(completeTime/rounds)) + " ms/round.");
    }
    
    private static Run test(Sort algo, Number[] array) {
        long time = System.currentTimeMillis();
        try { algo.sort(array); } catch (Throwable e) {
            time = System.currentTimeMillis() - time;
            Run r = new Run(time, algo.getArray(), algo.toString());
            if(showRoundResults) {
                System.out.println(r + ", Throwable: " + e.getClass().getName());
            } else {
                System.out.print("e");
            }
            return r;
        }
        try { algo.join(); } catch (Exception e) {}
        time = System.currentTimeMillis() - time;
        Run r = new Run(time, algo.getArray(), algo.toString());
        if(showRoundResults) System.out.println(r);
        else {
            if(!r.isSorted()) System.out.print("x");
            else if(rounds < 100) System.out.print("_");
        }
        return r;
    }
}















