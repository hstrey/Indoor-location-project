//
// Please report any problems with this app template to contact@estimote.com
//

import UIKit

import EstimoteProximitySDK

struct Content {
    let title: String
    let subtitle: String
}

class ViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var proximityObserver: ProximityObserver!

    var nearbyContent = [Content]()

    override func viewDidLoad() {
        super.viewDidLoad()


        let estimoteCloudCredentials = CloudCredentials(appID: "helmut-strey-gmail-com-s-p-2uq", appToken: "0cd210428b0c64f2510296eaa819d753")

        proximityObserver = ProximityObserver(credentials: estimoteCloudCredentials, onError: { error in
            print("ProximityObserver error: \(error)")
        })

        let zone = ProximityZone(tag: "helmut-strey-gmail-com-s-p-2uq", range: ProximityRange.near)
        zone.onContextChange = { contexts in
            self.nearbyContent = contexts.map {
                return Content(title: $0.attachments["helmut-strey-gmail-com-s-p-2uq/title"]!, subtitle: $0.deviceIdentifier)
            }

            self.collectionView?.reloadSections(IndexSet(integer: 0))
        }

        proximityObserver.startObserving([zone])
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nearbyContent.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCell", for: indexPath)

        let titleLabel = cell.viewWithTag(1) as! UILabel
        let subtitleLabel = cell.viewWithTag(2) as! UILabel

        let title = nearbyContent[indexPath.item].title
        let subtitle = nearbyContent[indexPath.item].subtitle

        cell.backgroundColor = Utils.color(forColorName: title)

        titleLabel.text = title
        subtitleLabel.text = subtitle

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxWidth = collectionView.frame.width - 20
        let maxHeight = collectionView.frame.height - (collectionView.layoutMargins.top + collectionView.layoutMargins.bottom)
        let singleCellHeight = maxHeight / CGFloat(nearbyContent.count) - (collectionViewLayout as! UICollectionViewFlowLayout).minimumLineSpacing

        return CGSize(width: maxWidth, height: singleCellHeight)
    }
}
