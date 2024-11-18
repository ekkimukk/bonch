/* Copyright (c) 2024 ekkimukk. All Rights Reserved. */

import java.util.*;

class Second extends Thread {
    public static final int N = 90_000_000;

    private int[] arr;
    public int res;

    public Second(int[] arr) {
        this.arr = arr;
    }

	@Override public void run() {
		{
            int mean = 0;
            for (int i = 50_000_000; i < 70_000_000; i++) {
                mean += arr[i];
            }
            mean /= N;
            System.out.println("2 > " + mean);
            this.res = mean;
        }
    }
}

class Third extends Thread {
    private int[] arr;
    public int res;

    public static final int N = 90_000_000;

    public Third(int[] arr) {
        this.arr = arr;
    }

	@Override public void run() {
		{
            int mean = 0;
            for (int i = 70_000_000; i < 90_000_000; i++) {
                mean += arr[i];
            }
            mean /= N;
            System.out.println("3 > " + mean);
            this.res = mean;
        }
    }
}

class Main {
    public static final int N = 90_000_000;

	static Second second;
	static Third third;

	public static void main(String[] args) {
        Random random = new Random();
        int[] arr = new int[N];
        for (int i = 0; i < N; i++) {
            arr[i] = random.nextInt();
        }

		second = new Second(arr);
		third = new Third(arr);
		System.out.println("Go");
		second.start();
        third.start();

        int mean = 0;
        {
            for (int i = 0; i < 50_000_000; i++) {
                mean += arr[i];
            }
            mean /= N;
            System.out.println("1 > " + mean);
        }

        System.out.println((mean + second.res + third.res) / 3);

		// if (second.isAlive() && third.isAlive()) {
		// 	try {
		// 		second.join();
		// 		third.join();
		// 	} catch (InterruptedException e) {}
		// 	System.out.println("1 WIN");
		// } else {
		// 	System.out.println("2 WIN");
		// }
	}
}
