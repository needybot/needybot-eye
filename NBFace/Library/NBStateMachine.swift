//
//  NBStateMachine.swift
//  NBFace
//
//  Created by David Glivar on 9/25/15.
//  Copyright © 2015 Wieden+Kennedy. All rights reserved.
//

import Foundation

/**
    Class that defines a simple state machine pattern (non strict).

    **Example**

    ```swift
    let machine = NBStateMachine()
    machine.addState("idle", on: {
        (payload: [String: AnyObject]?) -> () in
        if let payload: [String: AnyObject] = payload as? [String: AnyObject] {
            doSomethingWith(payload)
        }
    }, off: nil)
    machine.setState("idle", ["something": true])
    ```
*/
class NBStateMachine: NSObject {
    
    /// Typealias for a statemachine handler
    typealias Callback = ([String: AnyObject]?) -> ()
    
    /// Typealias for an array of statemachine handlers
    typealias CallbackStack = Dictionary<String, Callback?>
    
    private var currentState: String?
    private var currentTask: String?
    private var deferredCallback: Callback?
    private var locked = false
    
    var states = [String: [String: CallbackStack]]()
    
    /**
        ErrorType associated with any NBStateMachine error
        - Duplication: Attempted to define the same state more than once
        - Repeat: Attempted to transition to the currently set state
    */
    enum StateMachineError: ErrorType {
        /// Attempted to define the same state more than once
        case Duplication
        /// Attempted to transition to the currently set state
        case Repeat
    }
    
    /**
        Computable property that returns the current state of this state machine.
        (Read only)
    */
    var state: String? {
        return currentState
    }
    
    /**
     Computable property that returns the current task of this state machine.
     (Read only)
     */
    var task: String? {
        return currentTask
    }
    
    /**
        Adds a new state with `on` and `off` transition handlers.
        - Parameter name: The name of a new state to be added to the states dict
        - Parameter on: Optional handler for when this state is transitioned to
        - Parameter off: Optional handler for when this state is transitioned away from
        - Throws: NBStateMachine.StateMachineError
    */
    func addState(name: String, task: String! = "default", on: Callback! = nil, off: Callback! = nil) throws {
        if let t = states[task],
            let _ = t[name] {
            throw StateMachineError.Duplication
        }
        
        // If dict doesn't exist for task already, make sure to init it
        if states[task] == nil {
            states[task] = [String: CallbackStack]()
        }
        states[task]![name] = [ "on": on, "off": off ]
    }
    
    func lock() {
        locked = true
        print("locked")
    }
    
    /**
        Transitions the state machine from its current state to the next
        specified state, triggering transition handlers. The `on` handler
        will receive the given `payload` along with `["from": {previousState}]` dict
        merged in. The `off` handler will receive only the dict `["to": {nextState}]`.
        - Parameter state: The state to transition to
        - Parameter payload: Optional dictionary object to be passed to the `on` handler
        - Throws: NBStateMachine.StateMachineError
    */
    func setState(state: String, payload: [String: AnyObject]?, task: String? = "default") throws {
        if locked {
            print("Attempted to set state \(state), but machine is locked.")
            return
        }
        
        var task: String! = task!
        
        /*
        
        Double check that task exists for state
        Use default if not
        
        */
        if self.states[task] as [String: CallbackStack]! == nil ||
           self.states[task]![state] == nil {
            NB.log("-- overriding task to default")
            task = "default"
        }
        
        if let s = self.state, let t = self.task where task == t && state == s {
            throw StateMachineError.Repeat
        }
        
        let previous = self.state != nil ? self.state! : ""
        //let previousTask = self.task != nil ? self.task! : "default"
        currentState = state
        currentTask = task

        deferredCallback?(["to": state])
        
        if let prevTaskList = states[task],
           let deferred = prevTaskList[state]?["off"] where deferred != nil {
            deferredCallback = deferred
        } else if let prevTaskList = states["default"],
           let deferred = prevTaskList[state]?["off"] where deferred != nil {
            deferredCallback = deferred
        } else {
            deferredCallback = nil
        }
        
        if let callback = states[task]![state]?["on"] where callback != nil {
            var finalPayload: [String: AnyObject] = ["from": previous]
            if let _payload = payload {
                finalPayload = NB.mergeDicts(finalPayload, _payload)
            }
            callback!(finalPayload)
        }
    }
    
    func unlock() {
        locked = false
        print("unlocked")
    }
}