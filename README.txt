Supplementary Code for "Synaptic Convergence Regulates Synchronization-Dependent
Spike Transfer in Feedforward Neural Networks" 
Pachaya Sailamul, Jaeson Jang, Se-Bum Paik


There are two parts for code in this model.
1) The generation of feedforward network with three convergent structures; Gaussian-Gaussian
(GG) model, Uniform-Constant (UC), and Uniform-Exponential (UE) models. This part was implemented in MATLAB

2) Given the network structure generated in step 1, a feedforward neural network is built with NEURON simulator. 

Note that, there is option for "hetereogeneity testing", where activity of the source cells are not homogeneous (phase of each cell is random in normal distribution)

==============================================================
The generation of three convergent structure in MATLAB
==============================================================

Files in this part:
    Required Input Files
        Cells_position_source_layer1.txt //Position of cells in Source Layer
        Cells_position_target_layer2.txt //Position of cells in Target Layer
    Main File
        Step1_Generate_convergence_connections.m // Main MATLAB script
    Supporting Files
        func_gauss.m // Return gaussian value of a given distance
        GetCellsDistInfo.m // Return information about distribution of cell in a layer; cell position, distance matrix, nearest neighbor distance 
	GenPhase_random_cntrl.m // (optional) Generate random phase for source cells
Output:
    Input/ConvergentInput_GG_SIMCODE[..].txt // Convergence Connection with GG model
    Input/ConvergentInput_UC_SIMCODE[..].txt // Convergence Connection with UC model
    Input/ConvergentInput_UE_SIMCODE[..].txt // Convergence Connection with UE model
    Heterogeneity/Heterogeneity_SIMCODE[..].txt //Phase information for source cells 

==============================================================
The model in NEURON simulator
==============================================================

Files in this part:
    Required Input Files
        Cells_position[..].txt // Source and Target Cells position
        Input/ConvergentInput_XX_SIMCODE[..].txt // Convergence Connection with GG, UC, and UE model
    Main File
        step2_network_simulation.hoc // Main NEURON model and simulation script
    Supporting Files
        CaT.mod // mod files for T-type calcium channel  (from the NEURON simulator community)
        vecevent.mod // mod files for vector stream of events (from the NEURON simulator community)
        ranstream.hoc // random stream (from the NEURON simulator community)
        CellsTemplate.hoc // cells template
        Parameters.hoc // Cells and network parameters list

Output: 
    SomaVolt_SIMCODE[..].txt // Recorded membrane potential
    Soma_i_cap_SIMCODE[..].txt //Recorded membrane current (cap for capacitance)
    RecordConnList_SIMCODE[..].txt // Connection list
    InputSpkTrain_SIMCODE[..].txt // Input spike trains

==============================================================
Template for input and output text files
==============================================================

1) Input Cell position
    - Pattern of Cell position Files
        ------------------------------------
        Line#1 : N                      // # of cell
        Line#2 : X_1 Y_1                // Cell#1's position in X, Y coordinate
        .
        .
        Line#N+1 : X_N  Y_N             // Cell#N's position 
        ------------------------------------

    - Files in this catagory
        a. Cells_position_source_layer1.txt 
        b. Cells_position_target_layer2.txt

2) Convergence connections information (output of MATLAB code , input for NEURON model)
    - Pattern  (# of line = # of connections+1, # of column = 4)
        ------------------------------------
        Line#1    : #Connections  #Layer1  // Total number of Connection , Total number of cells in Layer1 
        Line#2    : pre      post     weight        delay  //Presynaptic cell ID     Postsynaptic cell ID    Weight of connection Signal transmission Delay           1           2           3       ..  cell#N  //ID of cells
        .
        .
        ------------------------------------

    - Files in this catagory
        a.Input/ConvergentInput_GG_SIMCODE[..].txt
        b.Input/ConvergentInput_UC_SIMCODE[..].txt
        c.Input/ConvergentInput_UE_SIMCODE[..].txt

3) Phase of source cells
    - Pattern (# of line = # of cells)
        ------------------------------------
        Line#1 : PHI_1    // Cell#1's phase
        Line#2 : PHI_2    // Cell#2's phase
        .
        .
        Line#N : PHI_N    // Cell#N's phase
        ------------------------------------

    - Files in this catagory
        a.Heterogeneity/Heterogeneity_SIMCODE[..].txt 
       
4) Output of recorded vector
    - Pattern  (# of line = tstop+3, # of column = # of cells)
        ------------------------------------
        Line#1    : #E          #I          tstop       0       ..  0       //#E = number of excitatory cell in the recorded vector, #I = number of inhibitory cell (0 in this model), tstop = run time, 0s were added to match total column of the data
        Line#2    : 0           1           2           3       ..  cell#N  //ID of cells
        Line#3    : v_0[0]      v_1[0]      v_2[0]      v_3[0]  ..  v_N[0]  //First recorded value of all the cells
        .
        .
        Line#N+3  : v_0[tstop]  v_1[tstop]  v_2[tstop]  v_3[tstop]  ..  v_N[tstop]  //Last recorded value of all the cells
        ------------------------------------

    - Files in this catagory
        a.Result/SomaVolt_SIMCODE[..].txt
        b.Result/Soma_i_cap_SIMCODE[..].txt 
        
5) Recorded Convergence connections (output from NEURON model)
    - Pattern  (# of line = # of connections+1, # of column = 4)
        ------------------------------------
        Line#1    : #Source  #target  #Connections  tstop  //Number of cell
        Line#2    : pre      post     weight        delay  //Presynaptic cell ID     Postsynaptic cell ID    Weight of connection Signal transmission Delay           1           2           3       ..  cell#N  //ID of cells
        .
        .
        ------------------------------------

    - Files in this catagory
        a.Result/RecordConnList_SIMCODE[..].txt
        
6) Recorded input spike train in layer 1
    - Pattern  (# of line = tstop+3, length = number of spikes)
        ------------------------------------
        Line#1    : #E       #I   tstop    //#E = number of excitatory cell in the recorded vector, #I = number of inhibitory cell (0 in this model), tstop = run time[ms]
        Line#2    : 0        t_1  t_2  ..  //ID of cells, spike location at time t_1, t_2, ... and so on
        .
        .
        Line#N+1  : cellID#  t_1  t_2  ..  // ID of cells, spike location at time t_1, t_2, ... and so on
        ------------------------------------

    - Files in this catagory
        a.Result/InputSpkTrain_SIMCODE[..].txt

==============================================================
Advice on running the program
==============================================================

For the first run, nrndll of all the mod files have to be made first by run "mknrndll" and choose the directory of this folder. 

