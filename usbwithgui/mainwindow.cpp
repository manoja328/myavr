#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include "usb.h"
#include <QMessageBox>
// Same as in main.c
#define USB_LED_OFF 0
#define USB_LED_ON  1
#define USB_DATA_OUT 2
/* Used to get descriptor strings for device identification */
static int usbGetDescriptorString(usb_dev_handle *dev, int index, int langid,
                                  char *buf, int buflen) {
    char buffer[256];
    int rval, i;

        // make standard request GET_DESCRIPTOR, type string and given index
    // (e.g. dev->iProduct)
        rval = usb_control_msg(dev,
        USB_TYPE_STANDARD | USB_RECIP_DEVICE | USB_ENDPOINT_IN,
        USB_REQ_GET_DESCRIPTOR, (USB_DT_STRING << 8) + index, langid,
        buffer, sizeof(buffer), 1000);

    if(rval < 0) // error
                return rval;

    // rval should be bytes read, but buffer[0] contains the actual response size
        if((unsigned char)buffer[0] < rval)
                rval = (unsigned char)buffer[0]; // string is shorter than bytes read

        if(buffer[1] != USB_DT_STRING) // second byte is the data type
                return 0; // invalid return type

        // we're dealing with UTF-16LE here so actual chars is half of rval,
        // and index 0 doesn't count
        rval /= 2;

        /* lossy conversion to ISO Latin1 */
        for(i = 1; i < rval && i < buflen; i++) {
                if(buffer[2 * i + 1] == 0)
                        buf[i-1] = buffer[2 * i];
                else
                        buf[i-1] = '?'; /* outside of ISO Latin1 range */
        }
        buf[i-1] = 0;

        return i-1;
}

static usb_dev_handle * usbOpenDevice(int vendor, char *vendorName,
                                      int product, char *productName) {
        struct usb_bus *bus;
        struct usb_device *dev;
        char devVendor[256], devProduct[256];

        usb_dev_handle * handle = NULL;

        usb_init();
        usb_find_busses();
        usb_find_devices();

        for(bus=usb_get_busses(); bus; bus=bus->next) {
                for(dev=bus->devices; dev; dev=dev->next) {
                        if(dev->descriptor.idVendor != vendor ||
               dev->descriptor.idProduct != product)
                continue;

            /* we need to open the device in order to query strings */
            if(!(handle = usb_open(dev))) {
                fprintf(stderr, "Warning: cannot open USB device: %s\n",
                    usb_strerror());
                continue;
            }

            /* get vendor name */
            if(usbGetDescriptorString(handle, dev->descriptor.iManufacturer, 0x0409, devVendor, sizeof(devVendor)) < 0) {
                fprintf(stderr,
                    "Warning: cannot query manufacturer for device: %s\n",
                    usb_strerror());
                usb_close(handle);
                continue;
            }

            /* get product name */
            if(usbGetDescriptorString(handle, dev->descriptor.iProduct,
               0x0409, devProduct, sizeof(devVendor)) < 0) {
                fprintf(stderr,
                    "Warning: cannot query product for device: %s\n",
                    usb_strerror());
                usb_close(handle);
                continue;
            }

            if(strcmp(devVendor, vendorName) == 0 &&
               strcmp(devProduct, productName) == 0)
                return handle;
            else
                usb_close(handle);
                }
        }

        return NULL;
}

usb_dev_handle *handle = NULL;
int nBytes = 0;
char buffer[256];


MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);

    handle = usbOpenDevice(0x16C0, "obdev.at", 0x05DC, "USBMANOJ");

    if(handle == NULL) {
        QMessageBox::information(this,"About LED programme","Could not find USB device!!");
        exit(1);
    }
}

MainWindow::~MainWindow()
{
    delete ui;
    usb_close(handle);
}

void MainWindow::on_pushButton_clicked()
{
    nBytes = usb_control_msg(handle,
        USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_ENDPOINT_IN,
        USB_LED_ON, 0, 0, (char *)buffer, sizeof(buffer), 5000);
    if(nBytes < 0)
        fprintf(stderr, "USB error: %sn", usb_strerror());
}

void MainWindow::on_pushButton_2_clicked()
{
    nBytes = usb_control_msg(handle,
        USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_ENDPOINT_IN,
        USB_LED_OFF, 0, 0, (char *)buffer, sizeof(buffer), 5000);
    if(nBytes < 0)
        fprintf(stderr, "USB error: %sn", usb_strerror());
}

void MainWindow::on_pushButton_3_clicked()
{
    nBytes = usb_control_msg(handle,
               USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_ENDPOINT_IN,
               USB_DATA_OUT, 0, 0, (char *)buffer, sizeof(buffer), 5000);
    ui->lineEdit->setText("got "+QString::number(nBytes)+" bytes: "+QString(buffer));
}
