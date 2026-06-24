#ifndef DATASTRUCTURES__GRAPH__DIRECTED_GRAPH_H_
#define DATASTRUCTURES__GRAPH__DIRECTED_GRAPH_H_

#include "graph/graph.h"

class DirectedGraph : public Graph {

  public:

    virtual ~DirectedGraph() = default;

    virtual void AddEdge(int source, int destination, int weight) override = 0;
    virtual void RemoveEdge(int source, int destination) override = 0;
    virtual bool HasEdge(int source, int destination) override = 0;

    virtual int GetEdgeWeight(int source, int destination) override = 0;
    virtual void SetEdgeWeight(int source, int destination, int weight) override = 0;

    virtual int OutDegree(int vertex) = 0;
    virtual int InDegree(int vertex) = 0;

    virtual bool IsPredecessor(int predecessor, int successor) = 0;
    virtual bool IsSuccessor(int successor, int predecessor) = 0;

};

#endif
