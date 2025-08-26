// kgs


const Number_of_Bottles = 600; //? L5

const Bottle_Size_Quarts = 3; //  liters

const Solids_hospital_milk = 13.0; // %

const Desired_Solid = 13.5; // %

const Hospital_Milk = 985; //KG   //? L11


const Hospital_Milk_Liters = Hospital_Milk / 1.032; // Convert kg to liters (1 kg = 1.032 liters for milk) //? L10


const Total_Volume_Liters = Number_of_Bottles * Bottle_Size_Quarts; // Total volume in liters

const total_Weight_KG = Total_Volume_Liters * 1.032; // Approximate weight per liter

const Kg_Solids_Hospital_Milk = (Hospital_Milk * Solids_hospital_milk) / 100; // Hospital milk solids in kg


const Total_Volume_Liter = Total_Volume_Liters; //? L17

const Total_Desired_Solids_Kg = (total_Weight_KG * Desired_Solid) / 100; //  ? L19   Total desired solids in kg


const Liters_Milk_Replacer_Mix_Need = Total_Volume_Liter - Hospital_Milk_Liters; //  ? L22  Liters of milk replacer mix needed


const Total_Kg_Milk_Replacer_Solids_Need =

  Total_Desired_Solids_Kg - Kg_Solids_Hospital_Milk; // ? L23  Total milk replacer solids needed in kg

const Total_Kg_Milk_Replacer_Mix_Need = Liters_Milk_Replacer_Mix_Need * 1.032; //? L25

const Total_Kg_Water_Need =

  Total_Kg_Milk_Replacer_Mix_Need - Total_Kg_Milk_Replacer_Solids_Need; //? L26


console.log({

  "Water Kg/Litres":

    Total_Kg_Water_Need.toFixed(2) +

    " Kg / " +

    (Total_Kg_Water_Need / 1.032).toFixed(2) +

    " Litres",

  "Milk Replacer Kg": Total_Kg_Milk_Replacer_Solids_Need.toFixed(2) + " Kg",

  "Water + Milk Replacer Lbs":

    Total_Kg_Milk_Replacer_Solids_Need + Total_Kg_Water_Need,

  "Hospital Milk Kg": Hospital_Milk.toFixed(2) + " Kg",

});
