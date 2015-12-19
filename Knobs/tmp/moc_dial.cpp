/****************************************************************************
** Meta object code from reading C++ file 'dial.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.5.1)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../QtKnobs/common/dial.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'dial.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.5.1. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
struct qt_meta_stringdata_Dial_t {
    QByteArrayData data[8];
    char stringdata0[67];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_Dial_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_Dial_t qt_meta_stringdata_Dial = {
    {
QT_MOC_LITERAL(0, 0, 4), // "Dial"
QT_MOC_LITERAL(1, 5, 12), // "colorChanged"
QT_MOC_LITERAL(2, 18, 0), // ""
QT_MOC_LITERAL(3, 19, 3), // "arg"
QT_MOC_LITERAL(4, 23, 18), // "borderColorChanged"
QT_MOC_LITERAL(5, 42, 6), // "bottom"
QT_MOC_LITERAL(6, 49, 5), // "color"
QT_MOC_LITERAL(7, 55, 11) // "borderColor"

    },
    "Dial\0colorChanged\0\0arg\0borderColorChanged\0"
    "bottom\0color\0borderColor"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_Dial[] = {

 // content:
       7,       // revision
       0,       // classname
       0,    0, // classinfo
       2,   14, // methods
       3,   30, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       2,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    1,   24,    2, 0x06 /* Public */,
       4,    1,   27,    2, 0x06 /* Public */,

 // signals: parameters
    QMetaType::Void, QMetaType::QColor,    3,
    QMetaType::Void, QMetaType::QColor,    3,

 // properties: name, type, flags
       5, QMetaType::Bool, 0x00095003,
       6, QMetaType::QColor, 0x00495003,
       7, QMetaType::QColor, 0x00495003,

 // properties: notify_signal_id
       0,
       0,
       1,

       0        // eod
};

void Dial::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        Dial *_t = static_cast<Dial *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->colorChanged((*reinterpret_cast< QColor(*)>(_a[1]))); break;
        case 1: _t->borderColorChanged((*reinterpret_cast< QColor(*)>(_a[1]))); break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        void **func = reinterpret_cast<void **>(_a[1]);
        {
            typedef void (Dial::*_t)(QColor );
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&Dial::colorChanged)) {
                *result = 0;
            }
        }
        {
            typedef void (Dial::*_t)(QColor );
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&Dial::borderColorChanged)) {
                *result = 1;
            }
        }
    }
#ifndef QT_NO_PROPERTIES
    else if (_c == QMetaObject::ReadProperty) {
        Dial *_t = static_cast<Dial *>(_o);
        Q_UNUSED(_t)
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< bool*>(_v) = _t->m_bottom; break;
        case 1: *reinterpret_cast< QColor*>(_v) = _t->m_color; break;
        case 2: *reinterpret_cast< QColor*>(_v) = _t->m_borderColor; break;
        default: break;
        }
    } else if (_c == QMetaObject::WriteProperty) {
        Dial *_t = static_cast<Dial *>(_o);
        Q_UNUSED(_t)
        void *_v = _a[0];
        switch (_id) {
        case 0:
            if (_t->m_bottom != *reinterpret_cast< bool*>(_v)) {
                _t->m_bottom = *reinterpret_cast< bool*>(_v);
            }
            break;
        case 1:
            if (_t->m_color != *reinterpret_cast< QColor*>(_v)) {
                _t->m_color = *reinterpret_cast< QColor*>(_v);
                Q_EMIT _t->colorChanged(_t->m_color);
            }
            break;
        case 2:
            if (_t->m_borderColor != *reinterpret_cast< QColor*>(_v)) {
                _t->m_borderColor = *reinterpret_cast< QColor*>(_v);
                Q_EMIT _t->borderColorChanged(_t->m_borderColor);
            }
            break;
        default: break;
        }
    } else if (_c == QMetaObject::ResetProperty) {
    }
#endif // QT_NO_PROPERTIES
}

const QMetaObject Dial::staticMetaObject = {
    { &QQuickPaintedItem::staticMetaObject, qt_meta_stringdata_Dial.data,
      qt_meta_data_Dial,  qt_static_metacall, Q_NULLPTR, Q_NULLPTR}
};


const QMetaObject *Dial::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *Dial::qt_metacast(const char *_clname)
{
    if (!_clname) return Q_NULLPTR;
    if (!strcmp(_clname, qt_meta_stringdata_Dial.stringdata0))
        return static_cast<void*>(const_cast< Dial*>(this));
    return QQuickPaintedItem::qt_metacast(_clname);
}

int Dial::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QQuickPaintedItem::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 2)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 2;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 2)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 2;
    }
#ifndef QT_NO_PROPERTIES
   else if (_c == QMetaObject::ReadProperty || _c == QMetaObject::WriteProperty
            || _c == QMetaObject::ResetProperty || _c == QMetaObject::RegisterPropertyMetaType) {
        qt_static_metacall(this, _c, _id, _a);
        _id -= 3;
    } else if (_c == QMetaObject::QueryPropertyDesignable) {
        _id -= 3;
    } else if (_c == QMetaObject::QueryPropertyScriptable) {
        _id -= 3;
    } else if (_c == QMetaObject::QueryPropertyStored) {
        _id -= 3;
    } else if (_c == QMetaObject::QueryPropertyEditable) {
        _id -= 3;
    } else if (_c == QMetaObject::QueryPropertyUser) {
        _id -= 3;
    }
#endif // QT_NO_PROPERTIES
    return _id;
}

// SIGNAL 0
void Dial::colorChanged(QColor _t1)
{
    void *_a[] = { Q_NULLPTR, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}

// SIGNAL 1
void Dial::borderColorChanged(QColor _t1)
{
    void *_a[] = { Q_NULLPTR, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 1, _a);
}
QT_END_MOC_NAMESPACE
