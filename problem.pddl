; problem.pddl
(define (problem openrouter-problem)
  (:domain openrouter)
  (:objects
    modelA modelB modelC modelD   - LLMModel
    providerX providerY           - Provider
    code multilingual             - Capability
    free basic standard premium   - CostTier
    small medium large            - ContextWindow
    req1 req2 req3 req4           - Request
  )
  (:init
    ; model/providers
    (provided_by modelA providerX)
    (provided_by modelB providerY)
    (provided_by modelC providerX)
    (provided_by modelD providerY)

    ; capabilities
    (has_capability modelA code)
    (has_capability modelB multilingual)
    (has_capability modelC code)
    (has_capability modelD multilingual)

    ; costs
    (cost_tier modelA standard)
    (cost_tier modelB premium)
    (cost_tier modelC basic)
    (cost_tier modelD free)

    ; context windows
    (context_window modelA medium)
    (context_window modelB large)
    (context_window modelC small)
    (context_window modelD large)

    ; open-source flags
    (is_open_source modelB)
    (is_open_source modelC)

    ; request requirements
    (requires_capability    req1 code)
    (requires_open_source   req2)
    (requires_cost_tier     req3 basic)
    (requires_context_window req4 large)
  )
  (:goal (and
    (routed req1 modelA)
    (routed req2 modelB)
    (routed req3 modelC)
    (routed req4 modelD)
  ))
)
