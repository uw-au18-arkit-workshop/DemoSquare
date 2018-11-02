//
//  ViewController.swift
//  AR Workshop 2
//
//  Created by Peter Kos on 10/26/18.
//  Copyright © 2018 UW. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true

		// Place our cube
		var transformMatrix = matrix_identity_float4x4

		transformMatrix.columns.3.x = 0
		transformMatrix.columns.3.y = 0
		transformMatrix.columns.3.z = -0.5

		let anchor = ARAnchor(transform: transformMatrix)

		sceneView.session.add(anchor: anchor)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }


    // MARK: - ARSCNViewDelegate

    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {

		// Create our Thicc Cube
		let shape = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0)

		let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: "dog.jpg")
        
        shape.materials = [material]

		// Throw it on a node
		let newNode = SCNNode(geometry: shape)

		return newNode
    }

	// MARK: - Error checking
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
