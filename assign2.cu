//CSCI415 - Assignment 2
//Original by: Saeed Salem, 2/25/2015
//Updated by: Otto Borchert, 2/20/2017
//To compile: make clean; make
//To run: ./assign2

#include <stdio.h>
#include <iostream>
#include <fstream>
#include <vector>

typedef std::vector< std::vector<int> > AdjacencyMatrix;
AdjacencyMatrix adjMatrix;

/* void averageForNodes(int *forSum,int *miOutput, int n, float *output)
{
	float sum =0;
	float average=0;
	for(int a =0; a<n;a++)
	{
		if(forSum[a]<2){
		 sum+=0;
		}
		else
		{
		 int top = 2*miOutput[a];
		 int botton = (forSum[a]-1)*forSum[a];
		 sum += (float)top/botton; 
		}

	}
	 	average = (float)sum/totalNodes;
		output = average;


}*/

/* void countForMi(int *initialArray, int *friends, int *outputMi, int *countForRound)
{
	int countOfMi =0;
	for(int a=0; a<friends.size()-1;a++)
	{
		for(int b=1; b<friends.size();b++)
		if(initialArray[]==1)
		countOfMi++;
		}
	}
	outputMi=countOfMi;
	
}*/

void printAdjMatrix(AdjacencyMatrix adjMatrix)
{
    for (int i=0; i<adjMatrix.size(); i++)
    {
        for (int j=0; j<adjMatrix[i].size(); j++) 
        {
            std::cout << adjMatrix[i][j] << " ";
        }
        std::cout << std::endl;
    }
}

void matrixToArray(AdjacencyMatrix adjMatrix, int *initialArray)
{
	int countOfNodes = 0;
	for(int i=0; i<adjMatrix.size();i++)
	{
		for(int j=0;j<adjMatrix[i].size();j++)
		{
		initialArray[countOfNodes]=adjMatrix[i][j];
			countOfNodes++;
		}
	}
}

void clustering_serial(int *input,float *output,int n)
{
		int sum =0;
		int countForMi =0;
		int friends [n];
		int countForRound=1;
		int forSum[n];
		int miOutput[n];
	
	for(int vi=0; vi<input.size();vi++)
	{
		 sum += input[vi];
		 if(input[vi]==1)
		{
		 friends[countForMi]= vi;
		 countForMi++;
		}
		int a = vi+1;
		int b = countForRound*n;
		if(a%b==0)
		{
		 int outputMi=0;
		 forSum[countForRound-1]=sum;
		 countForMi(input,friends,outputMi,countForRound);
		 miOutput[countForRound-1]=outputMi;
		 countForRound++;
		 
		}

	}
	averageForNodes(forSum,miOutput,n,output);

}

int main()
{
    std::fstream myfile("toyGraph1.txt",std::ios_base::in);
    int u,v;
    int maxNode = 0;
    std::vector< std::pair<int,int> > allEdges;
    while(myfile >> u >> v)
    {
        allEdges.push_back(std::make_pair(u,v));
        if(u > maxNode)
          maxNode = u;

        if(v > maxNode)
          maxNode = v;                 
    }

    int n = maxNode + 1;  //Since nodes starts with 0
    std::cout << "Graph has " << n << " nodes" << std::endl;

    adjMatrix = AdjacencyMatri x(n,std::vector<int>(n,0));
    //populate the matrix
    for(int i =0; i<allEdges.size() ; i++){
       u = allEdges[i].first;
       v = allEdges[i].second;
       adjMatrix[u][v] = 1;
       adjMatrix[v][u] = 1;
    } 
    //You can also make a list of neighbors for each node if you want.
    int initialArray[n*n];
    printAdjMatrix(adjMatrix);

    //convert adjacency matrix to 1 d array
	matrixToArray(adjMatrix, initialArray);	
	
    //TODO: Write serial clustering coefficent code; include timing and error checking
	float h_cpu_result=0;
	
	clustering_serial(initialArray,&h_cpu_result,n);

    //TODO: Write parallel clustering cofficient code; include timing and error checking

    //TODO: Compare serial and parallel results

    return 0;
}
