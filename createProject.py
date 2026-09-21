import shutil
from pathlib import Path
import argparse
import csv
import os
import sys



def parse_csv(file_path):
    """Opens and processes the provided CSV file."""
    # Check if the file exists before attempting to open it
    if not os.path.exists(file_path):
        print(f"Error: The file '{file_path}' does not exist.")
        sys.exit(1)

    try:
        print(f"--- Parsing File: {file_path} ---\n")

        with open(file_path, mode="r", encoding="utf-8") as csv_file:
            # DictReader maps the information in each row to a dict whose keys are the header names
            csv_reader = csv.DictReader(csv_file)

            # Print the detected column headers
        #    if csv_reader.fieldnames:
        #        print(f"Headers found: {', '.join(csv_reader.fieldnames)}")
        #        print("-" * 40)

            # Iterate through rows and print data
        #    for row_count, row in enumerate(csv_reader, start=1):
        #        print(f"Row {row_count}: {dict(row)}")
            return list(csv_reader)

    except Exception as e:
        print(f"An error occurred while reading the file: {e}")
        sys.exit(1)

def create_project(project_name, csv_reader, project_year ):
     
    dir_path = Path("Projects/"+project_name)
    try:
        # Action: Creates the directory.
        # parents=True creates any missing parent folders.
        # exist_ok=False forces it to throw an error if it exists.
        dir_path.mkdir(parents=True, exist_ok=False)
        print(f"Success: Directory '{dir_path}' has been created.")

    except FileExistsError:
        # Error Handling: Catches the default exception and prints your message.
        print(f"Error: The directory '{dir_path}' already exists!")
        # Optionally re-raise the error if you want the script to stop
        raise

    #loop through csv grid points
    for row_count, row in enumerate(csv_reader, start=1):
        #row_dict = dict(row)
        print(f"Row {row_count}: {row}")

        create_gridpoint_workspace( row['dataset'], project_name)
        create_gridpoint_files( row, project_name, project_year )
    create_super_launchers( csv_reader, project_name, project_year )

    
def create_gridpoint_workspace( gridpoint_name, project_name ):
    
    gridpoint_path = Path("Projects/"+project_name+"/"+gridpoint_name)
    try:
        gridpoint_path.mkdir(parents=True, exist_ok=False)
        print(f"Success: Directory '{gridpoint_path}' has been created.")
    except FileExistsError:
        print(f"Error: The directory '{gridpoint_path}' already exists!")
        raise

def create_gridpoint_files( project_data, project_name, project_year):
    if int(project_year) >= 2022:
        create_gridpoint_files_r3( project_data, project_name, project_year)
    if int(project_year) <= 2018:
        create_gridpoint_files_r2( project_data, project_name, project_year)

def create_super_launchers( csv_reader, project_name, project_year ):
    if int(project_year) >= 2022:
        create_super_launchers_r3( csv_reader, project_name, project_year)
    if int(project_year) <= 2018:
        create_super_launchers_r2( csv_reader, project_name, project_year)

def create_gridpoint_files_r3(  project_data, project_name, project_year ):
    #masses, ctau should already be placed in fragment and fragment should already link to GP, this stuff will not be done here
    #extract nevents from nvents field
    #replace content with gridpoint data in templates
    # Define file paths
    driver_year = "doDriver_"+project_year
    fragment = project_data['fragment']
    target_path = "./Projects/"+project_name+"/"+project_data['dataset']+"/"
    units_per_job = 800 #decent number @ expected 30% efficiency
    njobs = str(int(project_data['events'])/int(units_per_job))
    units_per_job = str(units_per_job)
    copy_and_update_template( "src/Templates/"+driver_year+".sh", target_path+driver_year+".sh", {"XXXX":project_data['dataset'],"PPPP":project_name, "FFFF":fragment}) 
    copy_and_update_template( "src/Templates/crab_stepGEN.py", target_path+"crab_stepGEN.py",{"XXXX":project_data['dataset'], "UUUU":units_per_job, "NNNN":njobs, "YYYY":project_data['dataset']+"_"+project_year})
    copy_and_update_template( "src/Templates/crab_stepDIGI.py", target_path+"crab_stepDIGI.py",{"XXXX":project_data['dataset'],"PPPP":project_name, "YYYY":project_data['dataset']+"_"+project_year})
    copy_and_update_template( "src/Templates/crab_stepAOD.py", target_path+"crab_stepAOD.py",{"XXXX":project_data['dataset'],"PPPP":project_name, "YYYY":project_data['dataset']+"_"+project_year})
    copy_and_update_template( "src/Templates/MakeList.sh", target_path+"Makelist.sh",{})
    copy_and_update_template( "src/Templates/runCrab.sh", target_path+"runCrab.sh",{"XXXX":project_data['dataset']})

def create_gridpoint_files_r2(  project_data, project_name, project_year ):
    #masses, ctau should already be placed in fragment and fragment should already link to GP, this stuff will not be done here
    #extract nevents from nvents field
    #replace content with gridpoint data in templates
    # Define file paths
    driver_year = "doDriver_"+project_year
    fragment = project_data['fragment']
    target_path = "./Projects/"+project_name+"/"+project_data['dataset']+"/"
    units_per_job = 800 #decent number @ expected 30% efficiency
    njobs = str(int(project_data['events'])/int(units_per_job))
    units_per_job = str(units_per_job)
    copy_and_update_template( "src/Templates/"+driver_year+".sh", target_path+driver_year+".sh", {"XXXX":project_data['dataset'],"PPPP":project_name, "FFFF":fragment})
    copy_and_update_template( "src/Templates/crab_stepGEN_UL.py", target_path+"crab_stepGEN_UL.py",{"XXXX":project_data['dataset'], "UUUU":units_per_job, "NNNN":njobs, "YYYY":project_data['dataset']+"_"+project_year})
    copy_and_update_template( "src/Templates/crab_stepSIM_UL.py", target_path+"crab_stepSIM_UL.py",{"XXXX":project_data['dataset'],"PPPP":project_name, "YYYY":project_data['dataset']+"_"+project_year})
    copy_and_update_template( "src/Templates/crab_stepDIGI_UL.py", target_path+"crab_stepDIGI_UL.py",{"XXXX":project_data['dataset'],"PPPP":project_name, "YYYY":project_data['dataset']+"_"+project_year})
    copy_and_update_template( "src/Templates/crab_stepHLT_UL.py", target_path+"crab_stepHLT_UL.py",{"XXXX":project_data['dataset'],"PPPP":project_name, "YYYY":project_data['dataset']+"_"+project_year})
    copy_and_update_template( "src/Templates/crab_stepAOD_UL.py", target_path+"crab_stepAOD_UL.py",{"XXXX":project_data['dataset'],"PPPP":project_name, "YYYY":project_data['dataset']+"_"+project_year})
    copy_and_update_template( "src/Templates/MakeList_UL.sh", target_path+"Makelist_UL.sh",{})
    copy_and_update_template( "src/Templates/runCrab_UL.sh", target_path+"runCrab_UL.sh",{"XXXX":project_data['dataset']})


def copy_and_update_template( source_path, destination_path, text_remap ):
    source = Path(source_path)
    destination = Path(destination_path)
    shutil.copy(source, destination)
    file_content = destination.read_text(encoding="utf-8")
    for key in text_remap:
        file_content = file_content.replace(key, text_remap[key])#key XXXX -> new string
    destination.write_text(file_content, encoding="utf-8")

def create_super_launcher( super_name,project_name, all_project_data, template_str):
    with open("Projects/"+project_name+"/"+super_name, "w", encoding="utf-8") as file:
        for project_data in all_project_data:
            line = template_str.format( project_data['dataset'] )
            file.write(line)

def create_super_launcher_year( super_name,project_name, all_project_data, template_str, year):
    with open("Projects/"+project_name+"/"+super_name, "w", encoding="utf-8") as file:
        for project_data in all_project_data:
            line = template_str.format( project_data['dataset'], year )
            file.write(line)


def create_super_launchers_r3( all_project_data, project_name,year ):
        
    #gen launch string
    GEN_template_str=  "pushd {0}; ./runCrab.sh 1 0 0 0 0; popd; \n"
    DIGI_template_str= "pushd {0}; ./runCrab.sh 0 1 0 0 0; popd; \n"
    AOD_template_str=  "pushd {0}; ./runCrab.sh 0 0 1 0 0; popd; \n"
    MINI_template_str= "pushd {0}; ./runCrab.sh 0 0 0 1 0; popd; \n"
    NANO_template_str= "pushd {0}; ./runCrab.sh 0 0 0 0 1; popd; \n"
    
    #generate each tier of crab launchers
    #run3 super launchers for crab
    create_super_launcher("supercrab_gensim.sh", project_name, all_project_data, GEN_template_str)
    create_super_launcher("supercrab_gensim2digi.sh", project_name, all_project_data, DIGI_template_str)
    create_super_launcher("supercrab_digi2aod.sh", project_name, all_project_data, AOD_template_str)
    create_super_launcher("supercrab_aod2mini.sh", project_name, all_project_data, MINI_template_str)
    create_super_launcher("supercrab_mini2nano.sh", project_name, all_project_data, NANO_template_str)


    #listmaking string
    g4d_template_str= "pushd {0}; ./Makelist.sh 1 0 0 0 {0} {1}; popd; \n"
    d4a_template_str= "pushd {0}; ./Makelist.sh 0 1 0 0 {0} {1}; popd; \n"
    a4m_template_str= "pushd {0}; ./Makelist.sh 0 0 1 0 {0} {1}; popd; \n"
    m4n_template_str= "pushd {0}; ./Makelist.sh 0 0 0 1 {0} {1}; popd; \n"

    create_super_launcher_year("superlist_gen2digi.sh", project_name, all_project_data, g4d_template_str, year)
    create_super_launcher_year("superlist_digi2aod.sh", project_name, all_project_data, d4a_template_str, year)
    create_super_launcher_year("superlist_aod2mini.sh", project_name, all_project_data, a4m_template_str, year)
    create_super_launcher_year("superlist_mini2nano.sh", project_name, all_project_data, m4n_template_str, year)

    driver_template_str = "pushd {0}; ./doDriver_{1}.sh; popd; \n"
    create_super_launcher_year("superdriver.sh", project_name, all_project_data, driver_template_str, year)

def create_super_launchers_r2( all_project_data, project_name, year ):

        #gen launch string
    GEN_template_str=  "pushd {0}; ./runCrab_UL.sh 1 0 0 0 0 0 0; popd; \n"
    SIM_template_str=  "pushd {0}; ./runCrab_UL.sh 0 1 0 0 0 0 0; popd; \n"
    DIGI_template_str= "pushd {0}; ./runCrab_UL.sh 0 0 1 0 0 0 0; popd; \n"
    HLT_template_str=  "pushd {0}; ./runCrab_UL.sh 0 0 0 1 0 0 0; popd; \n"
    AOD_template_str=  "pushd {0}; ./runCrab_UL.sh 0 0 0 0 1 0 0; popd; \n"
    MINI_template_str= "pushd {0}; ./runCrab_UL.sh 0 0 0 0 0 1 0; popd; \n"
    NANO_template_str= "pushd {0}; ./runCrab_UL.sh 0 0 0 0 0 0 1; popd; \n"

    #generate each tier of crab launchers
    #run2 super launchers for crab
    create_super_launcher("supercrab_gen.sh", project_name, all_project_data, GEN_template_str)
    create_super_launcher("supercrab_gen2sim.sh", project_name, all_project_data, SIM_template_str)
    create_super_launcher("supercrab_sim2digi.sh", project_name, all_project_data, DIGI_template_str)
    create_super_launcher("supercrab_digi2hlt.sh", project_name, all_project_data, HLT_template_str)
    create_super_launcher("supercrab_hlt2aod.sh", project_name, all_project_data, AOD_template_str)
    create_super_launcher("supercrab_aod2mini.sh", project_name, all_project_data, MINI_template_str)
    create_super_launcher("supercrab_mini2nano.sh", project_name, all_project_data, NANO_template_str)


    #listmaking string
    g4s_template_str= "pushd {0}; ./Makelist 1 0 0 0 0 0 {0} {1}; popd; \n"
    s4d_template_str= "pushd {0}; ./Makelist 0 1 0 0 0 0 {0} {1}; popd; \n"
    d4h_template_str= "pushd {0}; ./Makelist 0 0 1 0 0 0 {0} {1}; popd; \n"
    h4a_template_str= "pushd {0}; ./Makelist 0 0 0 1 0 0 {0} {1}; popd; \n"
    a4m_template_str= "pushd {0}; ./Makelist 0 0 0 0 1 0 {0} {1}; popd; \n"
    m4n_template_str= "pushd {0}; ./Makelist 0 0 0 0 0 1 {0} {1}; popd; \n"

    create_super_launcher_year("superlist_gen2sim.sh", project_name, all_project_data, g4s_template_str, year)
    create_super_launcher_year("superlist_sim2digi.sh", project_name, all_project_data, s4d_template_str, year)
    create_super_launcher_year("superlist_digi4hlt.sh", project_name, all_project_data, d4h_template_str, year)
    create_super_launcher_year("superlist_hlt2aod.sh", project_name, all_project_data, h4a_template_str, year)
    create_super_launcher_year("superlist_aod2mini.sh", project_name, all_project_data, a4m_template_str, year)
    create_super_launcher_year("superlist_mini2nano.sh", project_name, all_project_data, m4n_template_str, year)
    
    driver_template_str = "pushd {0}; ./doDriver_{1}.sh; popd; \n"
    create_super_launcher_year("superdriver.sh", project_name, all_project_data, driver_template_str, year)
    
def main():
    # 1. Initialize the argument parser
    parser = argparse.ArgumentParser(
        description="Generate a MC project from MC request csv format."
    )

    # 2. Add the CSV file path argument
    # We use an optional flag (-i or --input), but mark it as required
    parser.add_argument(
        "-i",
        "--input",
        required=True,
        help="Path to the input CSV file that you want to parse.",
    )
    parser.add_argument(
        "-n",
        "--name",
        required=True,
        help="Project Name",
    )
    parser.add_argument(
        "-y",
        "--year",
        required=True,
        help="Year",
    )


    # 3. Parse the arguments and convert them into a variable dictionary using vars()
    args_dict = vars(parser.parse_args())

    # 4. Extract the input file path from our variables dictionary
    csv_path = args_dict["input"]
    project_name = args_dict["name"]
    project_year = str(args_dict["year"])
    # 5. Run the CSV parsing logic
    #parse_csv(csv_path)
    create_project(project_name, parse_csv(csv_path), project_year)

if __name__ == "__main__":
    main()

