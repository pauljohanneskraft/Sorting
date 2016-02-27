
import sorting_algorithms.*;

public class UseCase {
    private static Number[] a = {};
    private static Sort[] algos = {
            new BubbleSort(a),
            new InsertionSort(a),
            new SelectionSort(a),
            new QuickSort(a)
    };
    
    public static void main(String[] args) {
        int count = 1000;
        int rounds = 1;
        Run[][] runs = new Run[rounds][algos.length];
        for(int j = 0; j < rounds; j++) {
            Number[] array = new Number[count];
            for(int i = 0; i < count; i++) {
                array[i] = new Number((int)(Math.random()*Integer.MAX_VALUE));
            }
            System.out.println(array);
            for(int k = 0; k < algos.length; k++) {
                algos[k].setArray(array.clone());
                runs[j][k] = test(algos[k]);
            }
        }
        System.out.println("done.");
    }
    
    private static Run test(Sort algo) {
        long time = System.currentTimeMillis();
        algo.run();
        try { algo.join(); }
        catch (Exception e) {}
        time = System.currentTimeMillis() - time;
        Run r = new Run(time, algo.getArray(), algo.toString());
        System.out.println(r);
        return r;
    }
}















