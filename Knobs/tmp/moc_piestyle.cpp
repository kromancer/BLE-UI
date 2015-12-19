/****************************************************************************
** Meta object code from reading C++ file 'piestyle.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.5.1)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../QtKnobs/styles/piestyle.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'piestyle.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.5.1. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
struct qt_meta_stringdata_PieStyle_t {
    QByteArrayData data[35];
    char stringdata0[335];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_PieStyle_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_PieStyle_t qt_meta_stringdata_PieStyle = {
    {
QT_MOC_LITERAL(0, 0, 8), // "PieStyle"
QT_MOC_LITERAL(1, 9, 12), // "valueChanged"
QT_MOC_LITERAL(2, 22, 0), // ""
QT_MOC_LITERAL(3, 23, 3), // "arg"
QT_MOC_LITERAL(4, 27, 17), // "multiColorChanged"
QT_MOC_LITERAL(5, 45, 15), // "minValueChanged"
QT_MOC_LITERAL(6, 61, 15), // "maxValueChanged"
QT_MOC_LITERAL(7, 77, 15), // "readOnlyChanged"
QT_MOC_LITERAL(8, 93, 14), // "percentChanged"
QT_MOC_LITERAL(9, 108, 11), // "modeChanged"
QT_MOC_LITERAL(10, 120, 4), // "Mode"
QT_MOC_LITERAL(11, 125, 12), // "colorChanged"
QT_MOC_LITERAL(12, 138, 12), // "styleChanged"
QT_MOC_LITERAL(13, 151, 8), // "CapStyle"
QT_MOC_LITERAL(14, 160, 11), // "setMinValue"
QT_MOC_LITERAL(15, 172, 11), // "setMaxValue"
QT_MOC_LITERAL(16, 184, 13), // "setMultiColor"
QT_MOC_LITERAL(17, 198, 10), // "setPercent"
QT_MOC_LITERAL(18, 209, 8), // "setValue"
QT_MOC_LITERAL(19, 218, 17), // "endValueFromPoint"
QT_MOC_LITERAL(20, 236, 1), // "x"
QT_MOC_LITERAL(21, 238, 1), // "y"
QT_MOC_LITERAL(22, 240, 5), // "value"
QT_MOC_LITERAL(23, 246, 8), // "minValue"
QT_MOC_LITERAL(24, 255, 8), // "maxValue"
QT_MOC_LITERAL(25, 264, 7), // "percent"
QT_MOC_LITERAL(26, 272, 10), // "multicolor"
QT_MOC_LITERAL(27, 283, 5), // "color"
QT_MOC_LITERAL(28, 289, 5), // "style"
QT_MOC_LITERAL(29, 295, 8), // "readOnly"
QT_MOC_LITERAL(30, 304, 4), // "mode"
QT_MOC_LITERAL(31, 309, 4), // "Flat"
QT_MOC_LITERAL(32, 314, 5), // "Curve"
QT_MOC_LITERAL(33, 320, 6), // "Normal"
QT_MOC_LITERAL(34, 327, 7) // "Percent"

    },
    "PieStyle\0valueChanged\0\0arg\0multiColorChanged\0"
    "minValueChanged\0maxValueChanged\0"
    "readOnlyChanged\0percentChanged\0"
    "modeChanged\0Mode\0colorChanged\0"
    "styleChanged\0CapStyle\0setMinValue\0"
    "setMaxValue\0setMultiColor\0setPercent\0"
    "setValue\0endValueFromPoint\0x\0y\0value\0"
    "minValue\0maxValue\0percent\0multicolor\0"
    "color\0style\0readOnly\0mode\0Flat\0Curve\0"
    "Normal\0Percent"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_PieStyle[] = {

 // content:
       7,       // revision
       0,       // classname
       0,    0, // classinfo
      17,   14, // methods
       9,  150, // properties
       2,  186, // enums/sets
       0,    0, // constructors
       0,       // flags
       9,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    1,   99,    2, 0x06 /* Public */,
       4,    1,  102,    2, 0x06 /* Public */,
       5,    1,  105,    2, 0x06 /* Public */,
       6,    1,  108,    2, 0x06 /* Public */,
       7,    1,  111,    2, 0x06 /* Public */,
       8,    1,  114,    2, 0x06 /* Public */,
       9,    1,  117,    2, 0x06 /* Public */,
      11,    1,  120,    2, 0x06 /* Public */,
      12,    1,  123,    2, 0x06 /* Public */,

 // slots: name, argc, parameters, tag, flags
      14,    1,  126,    2, 0x09 /* Protected */,
      15,    1,  129,    2, 0x09 /* Protected */,
      16,    1,  132,    2, 0x09 /* Protected */,
      17,    1,  135,    2, 0x09 /* Protected */,
      18,    1,  138,    2, 0x09 /* Protected */,

 // methods: name, argc, parameters, tag, flags
      19,    2,  141,    2, 0x02 /* Public */,
      19,    1,  146,    2, 0x22 /* Public | MethodCloned */,
      19,    0,  149,    2, 0x22 /* Public | MethodCloned */,

 // signals: parameters
    QMetaType::Void, QMetaType::Int,    3,
    QMetaType::Void, QMetaType::Bool,    3,
    QMetaType::Void, QMetaType::Int,    3,
    QMetaType::Void, QMetaType::Int,    3,
    QMetaType::Void, QMetaType::Bool,    3,
    QMetaType::Void, QMetaType::Int,    3,
    QMetaType::Void, 0x80000000 | 10,    3,
    QMetaType::Void, QMetaType::QColor,    3,
    QMetaType::Void, 0x80000000 | 13,    3,

 // slots: parameters
    QMetaType::Void, QMetaType::Int,    3,
    QMetaType::Void, QMetaType::Int,    3,
    QMetaType::Void, QMetaType::Bool,    3,
    QMetaType::Void, QMetaType::Int,    3,
    QMetaType::Void, QMetaType::Int,    3,

 // methods: parameters
    QMetaType::Int, QMetaType::QReal, QMetaType::QReal,   20,   21,
    QMetaType::Int, QMetaType::QReal,   20,
    QMetaType::Int,

 // properties: name, type, flags
      22, QMetaType::Int, 0x00495103,
      23, QMetaType::Int, 0x00495103,
      24, QMetaType::Int, 0x00495103,
      25, QMetaType::Int, 0x00495103,
      26, QMetaType::Bool, 0x00495003,
      27, QMetaType::QColor, 0x00495003,
      28, 0x80000000 | 13, 0x0049500b,
      29, QMetaType::Bool, 0x00495003,
      30, 0x80000000 | 10, 0x0049500b,

 // properties: notify_signal_id
       0,
       2,
       3,
       5,
       1,
       7,
       8,
       4,
       6,

 // enums: name, flags, count, data
      13, 0x0,    2,  194,
      10, 0x0,    2,  198,

 // enum data: key, value
      31, uint(PieStyle::Flat),
      32, uint(PieStyle::Curve),
      33, uint(PieStyle::Normal),
      34, uint(PieStyle::Percent),

       0        // eod
};

void PieStyle::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        PieStyle *_t = static_cast<PieStyle *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->valueChanged((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 1: _t->multiColorChanged((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 2: _t->minValueChanged((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 3: _t->maxValueChanged((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 4: _t->readOnlyChanged((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 5: _t->percentChanged((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 6: _t->modeChanged((*reinterpret_cast< Mode(*)>(_a[1]))); break;
        case 7: _t->colorChanged((*reinterpret_cast< QColor(*)>(_a[1]))); break;
        case 8: _t->styleChanged((*reinterpret_cast< CapStyle(*)>(_a[1]))); break;
        case 9: _t->setMinValue((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 10: _t->setMaxValue((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 11: _t->setMultiColor((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 12: _t->setPercent((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 13: _t->setValue((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 14: { int _r = _t->endValueFromPoint((*reinterpret_cast< qreal(*)>(_a[1])),(*reinterpret_cast< qreal(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = _r; }  break;
        case 15: { int _r = _t->endValueFromPoint((*reinterpret_cast< qreal(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = _r; }  break;
        case 16: { int _r = _t->endValueFromPoint();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = _r; }  break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        void **func = reinterpret_cast<void **>(_a[1]);
        {
            typedef void (PieStyle::*_t)(int );
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&PieStyle::valueChanged)) {
                *result = 0;
            }
        }
        {
            typedef void (PieStyle::*_t)(bool );
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&PieStyle::multiColorChanged)) {
                *result = 1;
            }
        }
        {
            typedef void (PieStyle::*_t)(int );
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&PieStyle::minValueChanged)) {
                *result = 2;
            }
        }
        {
            typedef void (PieStyle::*_t)(int );
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&PieStyle::maxValueChanged)) {
                *result = 3;
            }
        }
        {
            typedef void (PieStyle::*_t)(bool );
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&PieStyle::readOnlyChanged)) {
                *result = 4;
            }
        }
        {
            typedef void (PieStyle::*_t)(int );
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&PieStyle::percentChanged)) {
                *result = 5;
            }
        }
        {
            typedef void (PieStyle::*_t)(Mode );
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&PieStyle::modeChanged)) {
                *result = 6;
            }
        }
        {
            typedef void (PieStyle::*_t)(QColor );
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&PieStyle::colorChanged)) {
                *result = 7;
            }
        }
        {
            typedef void (PieStyle::*_t)(CapStyle );
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&PieStyle::styleChanged)) {
                *result = 8;
            }
        }
    }
#ifndef QT_NO_PROPERTIES
    else if (_c == QMetaObject::ReadProperty) {
        PieStyle *_t = static_cast<PieStyle *>(_o);
        Q_UNUSED(_t)
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< int*>(_v) = _t->m_value; break;
        case 1: *reinterpret_cast< int*>(_v) = _t->m_minValue; break;
        case 2: *reinterpret_cast< int*>(_v) = _t->m_maxValue; break;
        case 3: *reinterpret_cast< int*>(_v) = _t->m_percent; break;
        case 4: *reinterpret_cast< bool*>(_v) = _t->m_multiColor; break;
        case 5: *reinterpret_cast< QColor*>(_v) = _t->m_color; break;
        case 6: *reinterpret_cast< CapStyle*>(_v) = _t->m_style; break;
        case 7: *reinterpret_cast< bool*>(_v) = _t->m_readOnly; break;
        case 8: *reinterpret_cast< Mode*>(_v) = _t->m_mode; break;
        default: break;
        }
    } else if (_c == QMetaObject::WriteProperty) {
        PieStyle *_t = static_cast<PieStyle *>(_o);
        Q_UNUSED(_t)
        void *_v = _a[0];
        switch (_id) {
        case 0: _t->setValue(*reinterpret_cast< int*>(_v)); break;
        case 1: _t->setMinValue(*reinterpret_cast< int*>(_v)); break;
        case 2: _t->setMaxValue(*reinterpret_cast< int*>(_v)); break;
        case 3: _t->setPercent(*reinterpret_cast< int*>(_v)); break;
        case 4: _t->setMultiColor(*reinterpret_cast< bool*>(_v)); break;
        case 5:
            if (_t->m_color != *reinterpret_cast< QColor*>(_v)) {
                _t->m_color = *reinterpret_cast< QColor*>(_v);
                Q_EMIT _t->colorChanged(_t->m_color);
            }
            break;
        case 6:
            if (_t->m_style != *reinterpret_cast< CapStyle*>(_v)) {
                _t->m_style = *reinterpret_cast< CapStyle*>(_v);
                Q_EMIT _t->styleChanged(_t->m_style);
            }
            break;
        case 7:
            if (_t->m_readOnly != *reinterpret_cast< bool*>(_v)) {
                _t->m_readOnly = *reinterpret_cast< bool*>(_v);
                Q_EMIT _t->readOnlyChanged(_t->m_readOnly);
            }
            break;
        case 8:
            if (_t->m_mode != *reinterpret_cast< Mode*>(_v)) {
                _t->m_mode = *reinterpret_cast< Mode*>(_v);
                Q_EMIT _t->modeChanged(_t->m_mode);
            }
            break;
        default: break;
        }
    } else if (_c == QMetaObject::ResetProperty) {
    }
#endif // QT_NO_PROPERTIES
}

const QMetaObject PieStyle::staticMetaObject = {
    { &QQuickPaintedItem::staticMetaObject, qt_meta_stringdata_PieStyle.data,
      qt_meta_data_PieStyle,  qt_static_metacall, Q_NULLPTR, Q_NULLPTR}
};


const QMetaObject *PieStyle::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *PieStyle::qt_metacast(const char *_clname)
{
    if (!_clname) return Q_NULLPTR;
    if (!strcmp(_clname, qt_meta_stringdata_PieStyle.stringdata0))
        return static_cast<void*>(const_cast< PieStyle*>(this));
    return QQuickPaintedItem::qt_metacast(_clname);
}

int PieStyle::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QQuickPaintedItem::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 17)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 17;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 17)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 17;
    }
#ifndef QT_NO_PROPERTIES
   else if (_c == QMetaObject::ReadProperty || _c == QMetaObject::WriteProperty
            || _c == QMetaObject::ResetProperty || _c == QMetaObject::RegisterPropertyMetaType) {
        qt_static_metacall(this, _c, _id, _a);
        _id -= 9;
    } else if (_c == QMetaObject::QueryPropertyDesignable) {
        _id -= 9;
    } else if (_c == QMetaObject::QueryPropertyScriptable) {
        _id -= 9;
    } else if (_c == QMetaObject::QueryPropertyStored) {
        _id -= 9;
    } else if (_c == QMetaObject::QueryPropertyEditable) {
        _id -= 9;
    } else if (_c == QMetaObject::QueryPropertyUser) {
        _id -= 9;
    }
#endif // QT_NO_PROPERTIES
    return _id;
}

// SIGNAL 0
void PieStyle::valueChanged(int _t1)
{
    void *_a[] = { Q_NULLPTR, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}

// SIGNAL 1
void PieStyle::multiColorChanged(bool _t1)
{
    void *_a[] = { Q_NULLPTR, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 1, _a);
}

// SIGNAL 2
void PieStyle::minValueChanged(int _t1)
{
    void *_a[] = { Q_NULLPTR, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 2, _a);
}

// SIGNAL 3
void PieStyle::maxValueChanged(int _t1)
{
    void *_a[] = { Q_NULLPTR, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 3, _a);
}

// SIGNAL 4
void PieStyle::readOnlyChanged(bool _t1)
{
    void *_a[] = { Q_NULLPTR, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 4, _a);
}

// SIGNAL 5
void PieStyle::percentChanged(int _t1)
{
    void *_a[] = { Q_NULLPTR, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 5, _a);
}

// SIGNAL 6
void PieStyle::modeChanged(Mode _t1)
{
    void *_a[] = { Q_NULLPTR, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 6, _a);
}

// SIGNAL 7
void PieStyle::colorChanged(QColor _t1)
{
    void *_a[] = { Q_NULLPTR, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 7, _a);
}

// SIGNAL 8
void PieStyle::styleChanged(CapStyle _t1)
{
    void *_a[] = { Q_NULLPTR, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 8, _a);
}
QT_END_MOC_NAMESPACE
