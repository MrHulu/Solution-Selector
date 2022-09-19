#include <QtTest>

// add necessary includes here


#include <memory>
#include <iterator>
#include <QDebug>

#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QJsonObject>
#include <QJsonDocument>
#include <QJsonParseError>

class tst_test : public QObject
{
    Q_OBJECT
public:
    tst_test();
    ~tst_test();

private slots:
    void tst_testNet();

private:
    QNetworkAccessManager* m_netManager;
    QNetworkReply* m_netReply;
};

tst_test::tst_test()
{
    m_netManager = new QNetworkAccessManager(this);
}

tst_test::~tst_test() { }

void tst_test::tst_testNet()
{
    //auto url = QUrl(QString("https://github.com/MrHulu/Solution-Selector/raw/master/data/solution.json"));
    auto url = QUrl(QString("https://gs-files.oss-cn-hongkong.aliyuncs.com/test/solution-selector/solution.json"));
    QVERIFY(url.isValid());
    QNetworkRequest req(url);
    req.setAttribute(QNetworkRequest::RedirectPolicyAttribute, true);
    m_netReply = m_netManager->get(req);

    QSignalSpy spy(m_netReply, &QNetworkReply::finished);
    QVERIFY(spy.wait());
    QCOMPARE(spy.count(), 1);
    auto data = m_netReply->readAll();
    QJsonParseError jsonError;
    auto obj = QJsonDocument::fromJson(data, &jsonError).object();
    QVERIFY(jsonError.error == QJsonParseError::NoError);

    qDebug() << obj.value("eat").toObject().value("date").toArray().toVariantList();
    m_netReply->close();
}



QTEST_MAIN(tst_test)

#include "tst_test.moc"
