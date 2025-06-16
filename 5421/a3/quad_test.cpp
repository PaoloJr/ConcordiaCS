// QuadTest.cpp - Unit Tests for Quad
#include <iostream>
#include <sstream>
#include <cassert>
#include "Quad.h"

using std::stringstream;
using std::cout;

void testAccessors() {
    Quad q(1, 2, 3, 4);
    assert(q.get1() == 1);
    assert(q.get2() == 2);
    assert(q.get3() == 3);
    assert(q.get4() == 4);
}
void testSubscripts() {
  Quad q(1, 2, 3, 4);
  q *= 2;  // (2, 4, 6, 8);
  assert(q[1] == 2);
  assert(q[2] == 4);
  assert(q[3] == 6);
  assert(q[4] == 8);
  q[1] += 1; //3
  q[2] -= 1; //3
  q[3] *= 5; // 30
  q[4] /= 2; // 4
  assert(q == Quad(3, 3, 30, 4));
}

void testUnaryOperators() {
    Quad q(1, -2, 3, -4);
    Quad plusQ = +q;
    Quad minusQ = -q;
    assert(plusQ + minusQ == 0);
    assert(plusQ == q);
    assert(-minusQ == q);
    assert(-plusQ  == -q);
}

void testCompoundAssignments() {
    Quad a(1, 2, 3, 4);
    Quad b(2, 3, 4, 5);
    a += b; assert(a == Quad(3,5,7,9));
    a -= b; assert(a == Quad(1,2,3,4));
    a *= b; 
    assert(a == Quad(10,13,22,29));
    a /= b; 
    assert(a == Quad(1,2,3,4));
    assert(Quad(2, 3, 4, 5) == b);
}

void testScalarCompoundAssignments() {
    Quad q(1, 2, 3, 4);
    q += 1; assert(q == Quad(2,3,4,5));
    q -= 1; assert(q == Quad(1,2,3,4));
    q *= 2; assert(q == Quad(2,4,6,8));
    q /= 2; assert(q == Quad(1,2,3,4));
}

void testIncrementOperators() {
    Quad q(1,2,3,4);
    Quad r = ++q;
    assert(r == Quad(2,3,4,5));
    Quad s = q++;
    assert(s == Quad(2,3,4,5));
    assert(q == Quad(3,4,5,6));
    Quad t = --q;
    assert(t == Quad(2,3,4,5));
    Quad u = q--;
    assert(u == Quad(2,3,4,5));
    assert(q == Quad(1,2,3,4));
}

void testIOOperators() {
    Quad q(1, 2, 3, 4);
    stringstream ss("1 2 3 4");
    Quad r;
    ss >> r;
    assert(r == q);
}

void testEdgeCases() {
    Quad zero(0,0,0,0);
    assert(zero.det() == 0);
    assert(!zero.isInvertible());
    Quad identity(1,0,0,1);
    assert(identity.isOrthogonal());
    assert(identity.isInvertible());
    assert(identity.inverse() == identity);
}
void testBinaryArithmenticOperators()
{
   Quad a(1, 2, 3, 4);
   Quad b(8, 7, 6, 5);
   //(1, 2, 3, 4) x(8, 7, 6, 5) = (20, 17, 48, 41)
   Quad c = a * b;
   assert(c == Quad(20, 17, 48, 41));
   assert(c / a == a * b / a);
   assert(c / b == a);
   assert((1.0 + c) == (c + 1.0));
   assert((2.0 - c) == -(c - 2.0));
   assert((3.0 * c) == (c * 3.0));
   assert((4.0 / c) == 4.0 * c.inverse());
}
void testQuadSpecificFunctions()
{
  Quad a{1, 2, 1, 3};
  Quad b{3, -2, -1, 1};  
  assert(a * b == Quad(1, 0, 0, 1));
   assert(a.inverse() == b);
   assert(a.transpose().transpose() == a);
   assert((a + b).transpose() == a.transpose() + b.transpose());
   assert((a * b).det() == a.det() * b.det());
   assert(a.inverse().det() == 1.0 / a.det());
   // functions objects
   assert(a(1, 1) == a[1]);
   assert(a(1, 2) == a[2]);
   assert(a(2, 1) == a[3]);
   assert(a(2, 2) == a[4]);
   assert(++a(1, 1) == 2);
   assert(a(1, 2)++ == 2);
   assert(a(1, 2) == 3);
   assert(--a(2, 1) == 0);
   assert(a(2, 1)-- == 0);
   assert(a(2, 1) == -1);
}
int main() {
    testAccessors();
    testSubscripts();
    testUnaryOperators();
    testBinaryArithmenticOperators();
    testCompoundAssignments();
    testScalarCompoundAssignments();
    testIncrementOperators();
    testIOOperators();
    testEdgeCases();
    testQuadSpecificFunctions();
    cout << "All tests passed successfully!\n";
    return 0;
}

