#include <stdio.h>
#include "linkedlist.h"
#include <stdlib.h>

void init_list(LinkedList* list)
{
    list->head = NULL;
}

void push(LinkedList* list, void* data)
{
    Node* new_node = (Node*)malloc(sizeof(Node));
    new_node->data = data;
    new_node->next = list->head;
    list->head = new_node;
}

void* pop(LinkedList* list)
{
    Node* temp;
    void* data;

    if (list->head == NULL)
    return NULL;

    temp = list->head;
    data = temp->data;
    list->head = list->head->next;
    free(temp);
    return data;
}

int is_empty(LinkedList* list)
{
    return list->head == NULL;
}

void free_list(LinkedList* list)
{
    void* data;
    while (!is_empty(list))
    {    
        data = pop(list);
        free(data);
    }
}

