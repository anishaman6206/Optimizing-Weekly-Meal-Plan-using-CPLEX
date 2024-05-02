/*********************************************
 * OPL 22.1.1.0 Model
 * Author: anish
 * Creation Date: 02-Apr-2024 at 1:08:25 AM
 *********************************************/


using CP;
int M_V=12;
range Days = 1..7;
{string} Meal_Type=...;
{string} Meal_Nutrient=...;
range Meal_Variety = 1..M_V;
float Meal_Nutrient_Value[Meal_Variety][Meal_Nutrient]=...;
float Cost_per_serving[Meal_Variety]=...;
float Nutrients_score[Meal_Variety]=...;
float Min_Meal_Nutrient_Requirement[Meal_Nutrient]=...;
float Max_Meal_Nutrient_Requirement[Meal_Nutrient]=...;



// Define decision variables
dvar boolean x[Days][Meal_Variety]; // Binary variable representing whether meal i is selected on day j


// Define objective function
//minimize sum(i in Days, j in Meal_Variety) x[i][j]*Cost_per_serving[j]; 
//minimize sum(i in Days, j in Meal_Variety) x[i][j]*(Cost_per_serving[j]-Nutrients_score[j]);

// Define constraints
subject to {
    // Exactly 3 Meal_Variety served per day and all 3 Meal_Type should be different
    
    forall(i in Days) {
        sum(j in Meal_Variety) x[i][j] == 3;
      }
          //Same variety should not repeat more than 3 times a week and each meal should be atleast served once in a week
     forall(j in Meal_Variety) {
        sum(i in Days) x[i][j] <= 3;
        sum(i in Days) x[i][j] >= 1;
      }                  
        
         forall(i in Days){
           x[i][1]+x[i][4]+x[i][7]+x[i][10]==1;
           x[i][2]+x[i][5]+x[i][8]+x[i][11]==1;
           x[i][3]+x[i][6]+x[i][9]+x[i][12]==1;
         }           
    // Nutritional constraints
    forall(i in Days ,m in Meal_Nutrient)
       sum(j in Meal_Variety) x[i][j] * Meal_Nutrient_Value[j][m] >= Min_Meal_Nutrient_Requirement[m];
       
      forall(i in Days, m in Meal_Nutrient) 
       sum(j in Meal_Variety) x[i][j] * Meal_Nutrient_Value[j][m] <= Max_Meal_Nutrient_Requirement[m];
        }
        