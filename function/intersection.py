def intersection(arr1, arr2):
    same_values = set()
    num_checked = set()

    for num1 in arr1:
        if num1 not in num_checked:
            num_checked.add(num1)
            for num2 in arr2:
                if num1 == num2:
                    same_values.add(num1)                   
    same_values_list = list(same_values)
    return same_values_list

n = int(input("Enter number of first elements : ")) 
arr1 = list(map(int,input("Enter the first numbers : ").strip().split()))[:n] 
m = int(input("\nEnter number of second elements : ")) 
arr2 = list(map(int,input("Enter the second numbers : ").strip().split()))[:m] 

print (intersection(arr1, arr2))