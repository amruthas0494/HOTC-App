//
//  AppDelegate.swift
//  Photography-HOTC
//
//  Created by apple on 27/10/21.
//  Copyright © 2021 apple. All rights reserved.
//

import UIKit
import CoreData
import AVKit
import AVFoundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
      
     let manager = FileManager.default
                    let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first!
                    print(url.path)
                    let newFolderUrl = url.appendingPathComponent("HOTC").appendingPathComponent("SOBIA & ZOHAIB")
                    
                    let newFolderPhoto = newFolderUrl.appendingPathComponent("PHOTOS")
                    do {
                       try manager.createDirectory(at: newFolderPhoto, withIntermediateDirectories: true, attributes: [:])
                    }
                    catch{
                        print("error")
                    }
        let background = newFolderPhoto.appendingPathComponent("BACKGROUND")
                   let Prewedding = newFolderPhoto.appendingPathComponent("PREWEDDING")
                    let Haldi = newFolderPhoto.appendingPathComponent("HALDI")
                    let Mehandi = newFolderPhoto.appendingPathComponent("MEHANDI")
                    let Sangeet = newFolderPhoto.appendingPathComponent("SANGEET")
                    let Reception = newFolderPhoto.appendingPathComponent("RECEPTION")
                    let Muhurtham = newFolderPhoto.appendingPathComponent("MUHURTHAM")
                    let directoryNames = [background, Prewedding,Haldi, Mehandi, Sangeet, Reception, Muhurtham]
                    
                    for i in directoryNames {
                        do {
                            try manager.createDirectory(at: i, withIntermediateDirectories: true, attributes: [:])
                        }
                        catch{
                            print("error")
                        }
                    }
       
        let newFolderVideo = newFolderUrl.appendingPathComponent("VIDEOS")
               do {
                   try manager.createDirectory(at: newFolderVideo, withIntermediateDirectories: true, attributes: [:])
               }
               catch{
                   print("error")
               }
                let background1 = newFolderVideo.appendingPathComponent("BACKGROUND")
               let Prewedding1 = newFolderVideo.appendingPathComponent("PREWEDDING SHOOT")
               let Haldi1 = newFolderVideo.appendingPathComponent("HALDI")
               let Mehandi1 = newFolderVideo.appendingPathComponent("MEHANDI")
               let Sangeet1 = newFolderVideo.appendingPathComponent("SANGEET")
               let Reception1 = newFolderVideo.appendingPathComponent("RECEPTION")
               let Muhurtham1 = newFolderVideo.appendingPathComponent("MUHURTHAM")
               let directoryNames1 = [background1, Prewedding1, Haldi1, Mehandi1, Sangeet1, Reception1, Muhurtham1]
               for videos in directoryNames1 {
                   do {
                       try manager.createDirectory(at: videos, withIntermediateDirectories: true, attributes: [:])
                   }
                   catch{
                       print("error")
                   }
               }
        let folder1 = Prewedding1.appendingPathComponent("Thumbnails")
                      let folder2 = Haldi1.appendingPathComponent("Thumbnails")
                      let folder3 = Mehandi1.appendingPathComponent("Thumbnails")
                      let folder4 = Sangeet1.appendingPathComponent("Thumbnails")
                      let folder5 = Reception1.appendingPathComponent("Thumbnails")
                      let folder6 = Muhurtham1.appendingPathComponent("Thumbnails")
                      let newdirectory = [folder1, folder2, folder3, folder4, folder5, folder6]
                      for folder in newdirectory {
                          do {
                              try manager.createDirectory(at: folder, withIntermediateDirectories: true, attributes: [:])
                          }
                          catch{
                              print("error")
                          }
                      }
        let newBackground = newFolderUrl.appendingPathComponent("BACKGROUND")
                        do {
                           try manager.createDirectory(at: newBackground, withIntermediateDirectories: false, attributes: [:])
                        }
                        catch{
                            print("error")
                        }
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, mode: AVAudioSession.Mode.default, options: .mixWithOthers) //For playing volume when phone is on silent
        } catch {
            print(error.localizedDescription)
        }
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "Photography_HOTC")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}

