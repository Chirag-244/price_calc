# so this is some what a price calculator
SQINCHSQM=1550
WIDTH=90
# cost of process
MIS_VAR=25
# waste 
WASTE=1
STANDARD_CUT=60

def calculate_price(quality,cut_length,cost_price)->tuple:
    # calculate the price
    area=cut_length*WIDTH*2
    areasqm=area/SQINCHSQM
    standard_area=STANDARD_CUT*WIDTH
    standard_area_sqm=standard_area/SQINCHSQM
    gsm=quality/standard_area_sqm
    weight=gsm*areasqm
    weight=weight+((weight*WASTE)/100)
    cost=(weight*cost_price)/1000
    price=cost+MIS_VAR
    return (price,weight,gsm)

