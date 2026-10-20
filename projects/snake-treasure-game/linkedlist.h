#ifndef LINKEDLIST_H
#define LINKEDLIST_H

typedef struct Node
{
    void* data;
    struct Node* next;
} Node;

typedef struct 
{
    Node* head;
} LinkedList;

void init_list(LinkedList* list);
void push(LinkedList* list, void* data);
void* pop(LinkedList* list);
int is_empty(LinkedList* list);
void free_list(LinkedList* list);

#endif

