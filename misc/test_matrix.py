import amdprofilecontrol as a


# perform matrix multiplication given two matrices a and b

def matrix_multiplication(a, b):
    # check if the number of columns in matrix a is equal to the number of rows in matrix b
    if len(a[0]) != len(b):
        print("The number of columns in matrix a is not equal to the number of rows in matrix b")
        return None

    # create a matrix with the number of rows in matrix a and the number of columns in matrix b
    result = [[0 for i in range(len(b[0]))] for j in range(len(a))]

    # iterate through the rows of matrix a
    for i in range(len(a)):
        # iterate through the columns of matrix b
        for j in range(len(b[0])):
            # iterate through the columns of matrix a
            for k in range(len(a[0])):
                # multiply the elements of matrix a and matrix b and add the result to the corresponding element in the result matrix
                result[i][j] += a[i][k] * b[k][j]

    return result


# create two matrices
matrix_a = [[1, 2], [3, 4]]

matrix_b = [[5, 6], [7, 8]]


a.resume(1)
for i in range(100000):
    # perform matrix multiplication
    result = matrix_multiplication(matrix_a, matrix_b)
a.pause(1)



