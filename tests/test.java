/*Short circuiting*/
class test21
{
	public static void main(String[] args)
	{
		int sum;
		sum = 0;
		while(sum<100){
			System.out.println(sum);
			sum = sum + 1;
		}
	}
	public static int sum(){
		return 2;
	}
}
