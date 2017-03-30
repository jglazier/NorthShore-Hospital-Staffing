using JuMP

using GLPKMathProgInterface

#MODEL CONSTRUCTION
#------------------

sfLpModel = Model(solver=GLPKSolverMIP())

#INPUT DATA
#----------

c = [44.7; 44.7; 33]

A= [ 8;4;2; 0;0;0; 0;0;0; 0;0;0; 0;0;0; 0;0;0;
     0;0;0; 8;4;2; 0;0;0; 0;0;0; 0;0;0; 0;0;0;
     0;0;0; 0;0;0; 8;4;2; 0;0;0; 0;0;0; 0;0;0;
     0;0;0; 0;0;0; 0;0;0; 8;4;2; 0;0;0; 0;0;0;
     0;0;0; 0;0;0; 0;0;0; 0;0;0; 8;4;2; 0;0;0;
     0;0;0; 0;0;0; 0;0;0; 0;0;0; 0;0;0; 8;4;2
    ]
#demand + uncertainty
d = [7.99;	6.34;	4.57;	2.5;	.75;	0]
u = [.01; 1.41; 2.05; 2.58; 2.9; 0]
tr=1.66

n=6 # m = number of rows of A, n = number of columns of A

#VARIABLES
#---------

@defVar(sfLpModel, x[1:18] >= 0, Int) # Models x >=0

#CONSTRAINTS
#-----------

for i=1:n # for all rows do the following

  @addConstraint(sfLpModel, 8*x[3*i-2]+4*x[3*i-1]+2*x[3*i] >= tr*(d[i*1]+u[i*1]))

end # end of the for loop

# Number of available staff
f=12
p=12
r=0

for i=1:n
@addConstraint(sfLpModel, x[3*i-2] <=f)
@addConstraint(sfLpModel, x[3*i-1] <=p)
@addConstraint(sfLpModel, x[3*i] <=r)
end
#OBJECTIVE
#---------

@setObjective(sfLpModel, Min,
(x[1]+x[4]+x[7]+x[10]+x[13]+x[16])*c[1]+
(x[2]+x[5]+x[8]+x[11]+x[14]+x[17])*c[2]+
(x[3]+x[6]+x[9]+x[12]+x[15]+x[18])*c[3]) # minimize c'x



#THE MODEL IN A HUMAN-READABLE FORMAT
#------------------------------------

println("The optimization problem to be solved is:")
print(sfLpModel) # Shows the model constructed in a human-readable form

@time begin
status = solve(sfLpModel) # solves the model
end
#SOLVE IT AND DISPLAY THE RESULTS
#--------------------------------

y=x[1]+x[4]+x[7]+x[10]+x[13]+x[16]
z=x[2]+x[5]+x[8]+x[11]+x[14]+x[17]

println("Objective value: ", getObjectiveValue(sfLpModel)) # getObjectiveValue(model_name) gives the optimum objective value

println("Optimal solution is full time = \n", getValue(y))
println("Optimal solution is part time = \n", getValue(z))
