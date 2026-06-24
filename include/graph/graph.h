#ifndef DATASTRUCTURES__GRAPH__GRAPH_H_
#define DATASTRUCTURES__GRAPH__GRAPH_H_

#include <list>

class Graph {

  public:

    virtual ~Graph() = default;

    virtual bool AreAdjacent(int vertex1, int vertex2) = 0;
    virtual std::list<int> GetNeighbours(int vertex) = 0;

    virtual void AddVertex(int vertex) = 0;
    virtual void RemoveVertex(int vertex) = 0;
    virtual bool HasVertex(int vertex) = 0;

    virtual int Degree(int vertex) = 0;

    virtual void AddEdge(int vertex1, int vertex2, int weight) = 0;
    virtual void RemoveEdge(int vertex1, int vertex2) = 0;
    virtual bool HasEdge(int vertex1, int vertex2) = 0;

    virtual int GetEdgeWeight(int vertex1, int vertex2) = 0;
    virtual void SetEdgeWeight(int vertex1, int vertex2, int weight) = 0;

};

#endif
