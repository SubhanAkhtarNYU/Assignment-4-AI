; domain.pddl
(define (domain openrouter)
  (:requirements :strips :typing)
  
  (:types
    LLMModel
    Provider
    Capability
    Request
    CostTier
    ContextWindow
  )

  (:predicates
    (provided_by            ?m - LLMModel   ?p - Provider)
    (has_capability         ?m - LLMModel   ?c - Capability)
    (cost_tier              ?m - LLMModel   ?t - CostTier)
    (context_window         ?m - LLMModel   ?cw - ContextWindow)
    (requires_capability    ?r - Request     ?c - Capability)
    (requires_open_source   ?r - Request)
    (requires_cost_tier     ?r - Request     ?t - CostTier)
    (requires_context_window?r - Request     ?cw - ContextWindow)
    (is_open_source         ?m - LLMModel)
    (routed                 ?r - Request     ?m - LLMModel)
  )

  (:action route-by-capability
    :parameters (?r - Request ?m - LLMModel ?c - Capability)
    :precondition (and
      (requires_capability ?r ?c)
      (has_capability     ?m ?c)
    )
    :effect (routed ?r ?m)
  )

  (:action route-open-source-model
    :parameters (?r - Request ?m - LLMModel)
    :precondition (and
      (requires_open_source ?r)
      (is_open_source       ?m)
    )
    :effect (routed ?r ?m)
  )

  (:action route-by-cost
    :parameters (?r - Request ?m - LLMModel ?t - CostTier)
    :precondition (and
      (requires_cost_tier ?r ?t)
      (cost_tier          ?m ?t)
    )
    :effect (routed ?r ?m)
  )

  (:action route-by-context
    :parameters (?r - Request ?m - LLMModel ?cw - ContextWindow)
    :precondition (and
      (requires_context_window ?r ?cw)
      (context_window         ?m ?cw)
    )
    :effect (routed ?r ?m)
  )
)
